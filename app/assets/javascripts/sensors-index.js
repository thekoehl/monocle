NERD.SensorsIndex = {
  activeType: undefined,
  apiKey: undefined,
  contentContainer: undefined,
  view: undefined,
  sensors: undefined,

  init: function() {
    contentContainer = $('#content-container');
    if (contentContainer === false) { NERD.ErrorHandler('Could not find content container'); return;}

    this.activeType = 'hourly';
    this.apiKey = $('#api-key').val();
    this.registerHandlebarHelpers();
    this.loadSensors();
  },
  initDeleteLinks: function() {
    var self = this;
    this.view.find('.delete-link').click(function(e) {
      e.preventDefault();

      if (!confirm('Are you sure you want to delete this sensor?')) return;
      var $this = $(this);
      var uri = $this.attr('href') + '?api_key=' + self.apiKey;
      var id = $this.attr('data-for-sensor');

      $.ajax({url: uri, type: 'DELETE', success: function() {
        self.sensors = self.sensors.filter(function(value, index, ar) {
          if (value.id == id) return false;
          return true;
        });
        $this.parents('.sensors-index-item').fadeOut();
      }});
    });
  },
  initNavigationTabs: function() {
    var self = this;
    this.view.find('.nav-tabs a').click(function() {
      var $this = $(this);
      self.view.find('nav-tabs a').removeClass('active');
      self.activeType = $this.attr('data-time-range');
      if (self.activeType != 'hourly' && self.activeType != 'monthly' && self.activeType != 'daily') { NERD.ErrorHandler.showError('Invalid activetype ('+self.activeType+') selected'); return; }
      $this.addClass('active');
      self.sensorsLoadedCallback();
    })
    .each(function() {
      var $this = $(this);
      if ($this.attr('data-time-range') == self.activeType) {
        $this.parent().addClass('active');
        return;
      }
    });
  },
  dispose: function() {
    this.sensors = undefined;
  },
  loadSensors: function() {
    var self = this;
    $.ajax({
      url: '/api/sensors?api_key='+self.apiKey,
      success: function(response) {
        if (response.status != SUCCESS) { NERD.ErrorHandler.showError(response.message); return }
        self.sensors = response.sensors;
        self.sensorsLoadedCallback();
      }
    });
  },
  registerHandlebarHelpers: function() {
    Handlebars.registerHelper('last_value', function(data_points_array) {
      var len = data_points_array.length;
      if (len == 0) return;
      var idx = data_points_array.length > 0 ? len-1 : 0;

      return data_points_array[idx].value;
    });
  },
  sensorsLoadedCallback: function() {
    if (this.sensors == undefined) { NERD.ErrorHandler.showError('Attempted to load sensors when there werent any'); return; }
    if (this.view !== undefined) this.view.empty();

    this.sortSensors();

    this.view = $('#sensors-index-base').clone();
    this.view.attr('id', '#sensors-index');

    this.view.removeClass('hidden');
    this.view.appendTo($('#content-container'));

    for(var i = 0; i < this.sensors.length; i++) {
      var source   = $("#sensors-index-item-tmpl").html();
      var template = Handlebars.compile(source);
      var html = template(this.sensors[i]);
      var el = $(html);
      el.appendTo(this.view);
      if (this.activeType == 'hourly')
        NERD.DataChart.init(el.find('.chart-container'), this.sensors[i].data_points_hourly, this.sensors[i].Name, 'hourly');
      else if (this.activeType == 'monthly')
        NERD.DataChart.init(el.find('.chart-container'), this.sensors[i].data_points_monthly, this.sensors[i].Name, 'monthly');
      else if (this.activeType == 'daily')
        NERD.DataChart.init(el.find('.chart-container'), this.sensors[i].data_points_daily, this.sensors[i].Name, 'daily');
    };
    this.initDeleteLinks();
    this.initNavigationTabs();

        //this.dispose();
      },
      sortSensors: function() {
        this.sensors.sort(function(a,b) {
          if (a.Name < b.Name)
            return -1;
          if (a.Name > b.Name)
            return 1;
          return 0;

        });
      }
    };