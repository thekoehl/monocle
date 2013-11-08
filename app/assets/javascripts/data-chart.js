var NERD = NERD || {};

// Handles navigation of the big chart on the sensor display page
// Does not draw the chart, google charts is weird and this is done
// inline.
NERD.DataChart = {
    element: undefined,
    data_points: undefined,
    title: undefined,
    type: undefined,

    init: function(element, data_points, title, type) {
        if (element === false) { NERD.ErrorHandler.showError('No element passed'); return }
        if (data_points === false) { NERD.ErrorHandler.showError('No datapoints passed'); return }
        if (title === false) { NERD.ErrorHandler.showError('No title passed'); return }
        if (type === false || (type != 'hourly' && type != 'monthly' && type != 'daily')) { NERD.ErrorHandler.showError('Invalid or nonexistant chart type passed'); return }

        this.element = element;
        this.data_points = data_points;
        this.title = title;
        this.type = type;

        this.drawChart();
    },
    dispose: function() {
        this.data_points = undefined;
        this.title = undefined;
        this.element = undefined;
    },
    drawChart: function() {
        var width = this.element.width();
        var chart = nv.models.discreteBarChart()
            .x(function(d) { return d.label })
            .y(function(d) { return d.value })
            .height(190)
            .width(width)
            .options({
                showXAxis: false,
                showYAxis: false,
                forceY: [this.getChartMinimum()],
                margin: {left:0}
            });

        var data = this.getChartDatatable(null);
        var svg = this.element.find('svg')[0];
        d3.select(svg).datum(data).call(chart);
        nv.utils.windowResize(chart.update);
    },
    formatId: function(id) {
        if (this.type == 'hourly') {
            var splot = id.split(':00-');
            return splot[0];
        }
        else if (this.type == 'daily') {
            var splot = id.split('T');
            if (splot.length == 0) return id;
            return splot[0]
        }
        return id;
    },
    getChartDatatable: function(options) {
        var data = []

        for(var i = 0; i < this.data_points.length; i++) {
            var id = this.formatId(this.data_points[i].id);
            data.push({"label": id, "value": this.data_points[i].value});
        }
        var opts = [{
            area: true,
            values: data
        }];

        return opts;
    },
    getChartMinimum: function() {
        var min = 70;
        for(var i = 0; i < this.data_points.length; i++) {
            if (this.data_points[i].Value < min) min = this.data_points[i].Value;
        }
        return;
    }
};
