u = User.first

Group.destroy_all

(0..5).each do |group_number|
  g = Group.new
  g.user = u
  g.name = "Group #{group_number}"
  g.save!
  (0..5).each do |sensor_number|
    s = Sensor.new
    s.group = g
    s.name = "Sensor #{sensor_number}"
    s.units = "F"
    s.save!
    (0..24).each do |hour_from_now|
      t = Time.now - hour_from_now.hours
      d = DataPoint.new
      d.sensor = s
      d.logged_at = t.to_s
      d.value = Random.rand(100)
      d.save!
    end
  end
end