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

var NERD = NERD || {};

$().ready(function() {
    NERD.DataChart.init();
    NERD.BigDisplay.init();
});

NERD.DataChart = {
    init: function() {
    	if ($('#chart-container').length === 0) return;
    	this.initNavigation();
    },
    initNavigation: function() {
    	$('.chart-range').click(function() {
    		$('.chart-sub-nav li.active').removeClass('active');
    		$(this).parent().addClass('active');
    		drawChart(); // This directly references inHTML JS.  I know; but its the only way to get GCharts working right.
    		return false;
    	});
    }
}
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
	
}