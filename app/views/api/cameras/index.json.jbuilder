json.status "success"
json.cameras @cameras do |camera|
  json.id camera.id
  json.name camera.name
  json.latest_snapshot_url camera.latest_snapshot.url(:medium)
end