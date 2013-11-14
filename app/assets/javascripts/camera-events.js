var NERD = NERD || {};

NERD.CameraEventsIndex = {
    apiKey: undefined,
    camera_events: undefined,
    trigger: undefined,
    view: undefined,

    init: function() {
        this.apiKey = $('#api-key').val();
        this.trigger = $('#navigation-camera-events');
        if (this.trigger === false) return;

        this.contentContainer = $('#content-container');
        if (this.contentContainer === false) { NERD.ErrorHandler('Could not find content container'); return;}

        this.initTrigger();
    },
    initTrigger: function() {
        var self = this;
        this.trigger.on('click', function(e) {
            e.preventDefault();
            if ($('#camera-events-index').is(':visible')) {
                $('#camera-events-index').remove();
                return;
            }
            self.loadCameraEvents();
        });
    },
    cameraEventsLoadedCallback: function() {
        if (this.camera_events == undefined) { NERD.ErrorHandler.showError('Attempted to load camera events when there werent any'); return; }
        if (this.view !== undefined) this.view.remove();

        this.view = $('#camera-events-index-base').clone();
        this.view.attr('id', 'camera-events-index');

        this.view.removeClass('hidden');
        this.view.prependTo($('#content-container'));

        for(var i = 0; i < this.camera_events.length; i++) {
            var source   = $("#camera-events-index-item-tmpl").html();
            var template = Handlebars.compile(source);
            var html = template(this.camera_events[i]);
            var el = $(html);
            el.appendTo(this.view);
        };
        this.insertDeleteAllLink();
    },
    insertDeleteAllLink: function() {
        if (this.view == undefined) {NERD.ErrorHandler.showError('For some reason a view wasnt where we expected it to be.'); return; }
        var link = $('<a href="" class="delete-link btn btn-default">Delete All</a>');
        var self = this;
        link.click(function(e) {
            e.preventDefault();
            $.ajax({
                url: '/api/camera_events/destroy_all?api_key=' + self.apiKey,
                method: 'post',
                success: function(response) {
                    if (response.status != SUCCESS) { NERD.ErrorHandler.showError(response.message); return }
                    self.view.remove();
                }
            });
        });
        link.appendTo(this.view);
    },
    loadCameraEvents: function() {
        var self = this;
        $.ajax({
            url: '/api/camera_events?api_key=' + self.apiKey,
            success: function(response) {
                if (response.status != SUCCESS) { NERD.ErrorHandler.showError(response.message); return }
                self.camera_events = response.camera_events;
                self.cameraEventsLoadedCallback();
            }
        });
    }
};
