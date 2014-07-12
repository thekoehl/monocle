$(function() {
  ChartInitialize();
});

function ChartInitialize() {
  var chartContainer = $('#chart-container');
  if (chartContainer.length == 0) return;

  var ctx = chartContainer.get(0).getContext("2d");
  var id = chartContainer.attr('data-sensor-id');
  $.get('/api/sensors/' + id + '.json', function(data) {
    var options = ChartGetOptions();
    var chart = new Chart(ctx).Line(data, options);
  });
  //var data = ChartGetData();
  //var options = ChartGetOptions();
  //var chart = new Chart(ctx).Line(data, options);
};

function ChartGetData() {
  var data = {
    labels: ["January", "February", "March", "April", "May", "June", "July" ],
    datasets: [
        {
          label: "My First dataset",
         fillColor: "rgba(220,220,220,0.2)",
       strokeColor: "rgba(220,220,220,1)",
       pointColor: "rgba(220,220,220,1)",
       pointStrokeColor: "#fff",
       pointHighlightFill: "#fff",
       pointHighlightStroke: "rgba(220,220,220,1)",
       data: [65, 59, 80, 81, 56, 55, 40]
        }        ]
  };
  return data;
};
function ChartGetOptions() {
  var options = Chart.defaults.global;
  options.responsive = true;
  return Chart.defaults.global;
};
