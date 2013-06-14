# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# We'll just assume this is it
user = User.last

sensor1 = user.sensors.find_or_create_by_name "Test 1",
          	reporter: "Test Data Source"
sensor2 = user.sensors.find_or_create_by_name "Test 2",
          	reporter: "Test Data Source"

(0..25).each do |i|	
	t = Time.now - i.hours
	dp1 = DataPoint.new(value: i, reporter: "test reporter", units: "T")
	dp1.created_at = t

	dp2 = DataPoint.new(value: i*2, reporter: "test reporter", units: "T")
	dp2.created_at = t
	
	sensor1.data_points << dp1
	sensor2.data_points << dp2

	dp1.update_attribute('created_at_hourly', t.strftime("%a %m/%d %H:00"))
	dp2.update_attribute('created_at_hourly', t.strftime("%a %m/%d %H:00"))
end