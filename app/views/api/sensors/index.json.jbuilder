json.status "success"
json.sensors @sensors do |sensor|
  json.name sensor.name
  json.units sensor.units
  json.data_points_hourly sensor.data_points.where(["created_at > ?", Time.now-1.day]).segmented('hourly').average(:value) do |dp|
    json.id dp[0]
    json.value dp[1]
  end
  json.data_points_daily sensor.data_points.where(["created_at > ?", Time.now-14.days]).segmented('daily').average(:value) do |dp|
    json.id dp[0]
    json.value dp[1]
  end
  json.data_points_monthly sensor.data_points.segmented('monthly').average(:value) do |dp|
    json.id dp[0]
    json.value dp[1]
  end
end