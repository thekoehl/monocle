json.sensors @sensors do |sensor|
  json.name sensor.name
  json.last_update sensor.updated_at
  json.last_value sensor.last_data_point.value
end