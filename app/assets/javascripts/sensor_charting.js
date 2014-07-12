$(function() {
  ChartInitialize();
});
var chartContainer; // OOOOH YEAAAAH
var chart; // OOOH YEAAAAH AGAIN
function ChartInitialize() {
  chartContainer = $('#chart-container');
  if (chartContainer.length == 0) return;

  ChartGetData();
  ChartHookupCallbacks();
};

function ChartGetData() {
  var ctx = chartContainer.get(0).getContext("2d");
  var id = chartContainer.attr('data-sensor-id');
  var timespan = $('#chart-range').val();
  $.get('/api/sensors/' + id + '.json?timespan=' + timespan, function(data) {
    var options = ChartGetOptions();
    chart = new Chart(ctx).Line(data, options);
  });

};
function ChartGetOptions() {
  var options = Chart.defaults.global;
  options.responsive = true;
  return Chart.defaults.global;
};
function ChartHookupCallbacks() {
  $('#chart-range').change(function() {
    chart.clear();
    chart.destroy();
    ChartGetData();
  });
};
