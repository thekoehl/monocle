// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
//= require data_chart

$().ready(function() {
	NERD.AlarmResetHandler.init();
    NERD.DataChart.init();
    NERD.BigDisplay.init();
    NERD.MainMenu.init();
});

NERD.AlarmResetHandler = {
	init: function() {
		if ($('.alarm-reset-link').length === 0) return;
		this.initAlarmResetLinks();
	},
	initAlarmResetLinks: function() {
		$('.alarm-reset-link').click(function() {
			var id = $(this).attr('alarm-id');
			var clickedLink = this;

			$.ajax({				
				type: 'POST',
				url: '/alarms/'+id+'/reset',
				success: NERD.AlarmResetHandler.handleResetSuccess,
				error: NERD.AlarmResetHandler.handleResetFailure
			});
		});
	},
	handleResetSuccess: function(data) {
		if (data.success != true) { alert(data.message); return; }
		var alertContainer = $('.alert-error');
		var alarmId = data.alarm.id;

		if (alertContainer.children().length == 1) {
			alertContainer.fadeOut();
			return;
		}

		var alarmLink = alertContainer.find('a[alarm-id="' + alarmId + '"]');
		if (alarmLink.length === 0) return;
		alarmLink.fadeOut();
	},
	handleResetFailure: function() {
		alert('We\'re sorry, but your request has failed.  Please try refreshing the page and trying again.');
	}
};



// Handles refreshing /sensors/big_display
NERD.BigDisplay = {
	init: function() {
		if($('.sensor-big-display').length === 0) return;

		$('.navbar-inner').hide();
		$('body').addClass('sensor-green-display');
		setInterval(function() {
			if ($('.sensor-big-display span.glowing').length === 0)
				$('.sensor-big-display span').addClass('glowing');
			else
				$('.sensor-big-display span').removeClass('glowing');
			},
			2000
		);
	}
};

// Handles highlighting the active menu entry.
NERD.MainMenu = {
    init: function() {
        this.highlightActiveEntry();
    },
    highlightActiveEntry: function() {
        var url = document.URL.replace('http://', '').split('/');
        var controller = url.length > 1 && url[1] != "" ? url[1] : null;
        var action = url.length > 2 ? url[2] : null;

        if (controller == null && action == null) {
            $('.nav li').first().addClass('active');
            return;
        }

        $('.navbar .nav > li > a').each(function () {
            var $this = $(this);
            var destinationUrl = $this.attr('href').replace('http://', '').split('/');

            var destinationController = destinationUrl.length > 1 ? destinationUrl[1] : null;

            if (destinationController == controller) {
                $this.parent().addClass('active');
                return;
            }
        });
    }
};