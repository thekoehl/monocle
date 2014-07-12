json.labels @x_axis_labels
json.datasets [0] do |i|
  json.fillColor 'rgba(220,220,220,0.2)'
  json.strokeColor 'rgba(220,220,220,1)'
  json.pointColor 'rgba(220,220,220,1)'
  json.pointStrokeColor '#fff'
  json.pointHighlightFill '#fff'
  json.pointHighlightStroke 'rgba(220,220,220,1)'
  json.label @sensor.name
  json.data @values
end
