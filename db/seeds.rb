# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.first
user.sensors.destroy_all

Timecop.freeze do
	r = Random.new
	start_time = Time.now
	floor_time = Time.now - (24*7).hours
	(0..5).each do |s|
		sensor = Sensor.new(name: "Sensor #{s}", units: "t/s")
		sensor.user = user
		sensor.save!
		puts ""
		puts "Creating test datapoints..."

		current_time = start_time
		while(current_time > floor_time) do
			print "."; $stdout.flush
			v = Random.rand(0..55)
			d = Time.local(current_time.year, current_time.month, current_time.day, current_time.hour,0,0)

			Timecop.travel(d)

			data_point = DataPoint.new(value: v)
			data_point.sensor = sensor
			data_point.save!

			current_time = current_time - 1.hour
		end
	end
end