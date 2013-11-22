json.status "success"
json.camera_events @camera_events do |camera_event|
  json.id camera_event.id
  json.created_at camera_event.created_at
  json.location camera_event.location
  json.event_recording_url camera_event.event_recording.url
end