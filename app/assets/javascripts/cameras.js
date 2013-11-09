var NERD = NERD || {};

NERD.CamerasIndex = {
    apiKey: undefined,
    cameras: undefined,
    trigger: undefined,
    view: undefined,

    init: function() {
        this.apiKey = $('#api-key').val();
        this.trigger = $('#navigation-cameras');
        if (this.trigger === false) return;

        this.contentContainer = $('#content-container');
        if (this.contentContainer === false) { NERD.ErrorHandler('Could not find content container'); return;}

        this.initTrigger();
    },
    initTrigger: function() {
        var self = this;
        this.trigger.on('click', function(e) {
            e.preventDefault();
            if ($('#cameras-index').is(':visible')) {
                $('#cameras-index').remove();
                return;
            }
            self.loadCameras();
        });
    },
    camerasLoadedCallback: function() {
        if (this.cameras == undefined) { NERD.ErrorHandler.showError('Attempted to load cameras when there werent any'); return; }
        if (this.view !== undefined) this.view.remove();

        //this.sortCameras();

        this.view = $('#cameras-index-base').clone();
        this.view.attr('id', 'cameras-index');

        this.view.removeClass('hidden');
        this.view.prependTo($('#content-container'));

        for(var i = 0; i < this.cameras.length; i++) {
            var source   = $("#cameras-index-item-tmpl").html();
            var template = Handlebars.compile(source);
            var html = template(this.cameras[i]);
            var el = $(html);
            el.appendTo(this.view);
        };
    },
    loadCameras: function() {
        var self = this;
        $.ajax({
            url: '/api/cameras?api_key=' + self.apiKey,
            success: function(response) {
                if (response.status != SUCCESS) { NERD.ErrorHandler.showError(response.message); return }
                self.cameras = response.cameras;
                self.camerasLoadedCallback();
            }
        });
    }
};