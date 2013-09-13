var NERD = NERD || {};

// Handles navigation of the big chart on the sensor display page
// Does not draw the chart, google charts is weird and this is done
// inline.
NERD.DataChart = {
    init: function() {
    	if ($('.sensor-chart-container').length === 0) return;
        this.initNavigation();
        this.initChart();
    },
    initChart: function() {
        google.setOnLoadCallback(this.initChartCallback);
    },
    initChartCallback: function() {
        $('.sensor-chart-container').each(function() {
            var chartContainer = $(this);
            var options = NERD.DataChart.getChartSettings(chartContainer);

            var data = NERD.DataChart.getChartDatatable(options);

            $.ajax({
                url: '/sensors/' + options.sensorIds.join(',') + '/data_points?chart_range=' + options.chartRange,
                success: function(response) {
                    NERD.DataChart.drawChart(options, chartContainer, data, response);            
                }
            });
        });
    },
    // THIS WILL FAIL IF SENSORS DON'T HAVE SAME START POINTS
    // TODO: FIX THIS
    drawChart: function(options, chartContainer, data, response) {
        for(var i=0; i< response[0].length; i++) {
            var dataToAdd = [ response[0][i][0], parseInt(response[0][i][1]) ];            
            for(var k = 1; k < response.length; k++) {
                dataToAdd.push(parseInt(response[k][i][1]));
            }
            data.addRow(dataToAdd);
        }
        var chartOptions = NERD.DataChart.getGoogleChartOptions(options);
        var chart = new google.visualization.AreaChart(chartContainer[0]);
        chart.draw(data, chartOptions);
    },
    initNavigation: function() {
    	$('.chart-range').click(function() {
    		$('.chart-sub-nav li.active').removeClass('active');
    		$(this).parent().addClass('active');
    		NERD.DataChart.initChartCallback();
    		return false;
    	});
    },
    findSelectedChartRange: function() {
        var chartRangeEl = $('.chart-sub-nav > li.active > a.chart-range').first();
        var chartRange = chartRangeEl.attr('chart-range');
        if (chartRange == undefined) chartRange = 'this-day';

        return chartRange;
    },
    getChartDatatable: function(options) {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Value');
        for(var i = 0; i < options.sensorIds.length; i++) {
            data.addColumn('number', options.sensorNames[i]);
        };

        return data;
    },
    getGoogleChartOptions: function(options) {
        var chartOptions = {
            'backgroundColor': '#ffffff',
            'foregroundColor': '#000000',
            'colors': ['#31b0d5', '#CD563E', '#CCE0AB', '#F7C087', '#A9C1D9'],
            'title': options.sensorNames.join(','),
            'width': '100%',
            'height': 350,
            'chartArea':{ left:0,top:0,height: 330, width:"100%" },
            'areaOpacity': 0.65,
            'hAxis': {
                'textPosition': 'in',
                'maxAlternation': 1,
                'showEvery': 5,
                'textStyle': { 'color': '#000000' }
            },
            'vAxis': {
                'textPosition': 'in',
                'textStyle': { 'color': '#000000' }
            },
            'titlePosition': 'in',
            'titleTextStyle': {'color': '#000000'}
        };
        return chartOptions;
    },
    getChartSettings: function(el) {
        return {
            chartRange: NERD.DataChart.findSelectedChartRange(),
            sensorIds: el.attr('data-sensor-id').split(','),
            sensorNames: el.attr('data-sensor-name').split(','),
            sensorUnits: el.attr('data-sensor-units')
        };
    }
};