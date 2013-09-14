# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# We'll just assume this is it
user = User.last
Sensor.destroy_all
(0..15).each do |i|
	puts "Working with sensor #{i}..."
	sensor = user.sensors.find_or_create_by_name "Test #{i}", reporter: "Test Data Source", group_name: "Group #{(i/5).to_s}"
	(0..45).each do |j|
		t = Time.now - j.hours
		dp = DataPoint.new(value: rand(0..325), reporter: "test reporter", units: "T")
		dp.created_at = t
		sensor.data_points << dp
		dp.update_attribute('created_at_hourly', t.strftime("%a %m/%d %H:00"))
	end
end