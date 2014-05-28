u = User.first

puts "Destroying previous data..."
Group.destroy_all
puts "Rebuilding..."

(0..1).each do |group_number|
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
    (0..48).each do |hour_from_now|
      [0].each do |minutes_from_now|
        t = Time.now - hour_from_now.hours
        t -= minutes_from_now.minutes
        d = DataPoint.new
        d.sensor = s
        d.logged_at = t.to_s
        d.value = Random.rand(500)
        d.save!
      end
    end
  end
end
