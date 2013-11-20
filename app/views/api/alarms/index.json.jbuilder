json.status "success"
json.alarms @alarms do |alarm|
  json.id alarm.id
  json.sensor_name alarm.sensor.name
  json.type alarm.alarm_type
  json.trigger_value alarm.trigger_value
end