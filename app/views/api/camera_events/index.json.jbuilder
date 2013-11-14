json.status "success"
json.cameras @camera_events do |camera_event|
  json.id camera.id
  json.name camera_event.name
  json.event_recording_url camera_event.event_recording_url
end