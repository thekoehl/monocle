# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.first
user.numeric_sensors.destroy_all
user.stateful_sensors.destroy_all

Timecop.freeze do
	r = Random.new
	start_time = Time.now
	floor_time = Time.now - (24*16).hours
	(0..5).each do |s|
		sensor = NumericSensor.new(name: "Sensor #{s}", units: "t/s", user: user)
    stateful_sensor = StatefulSensor.new(name: "Stateful Sensor #{s}", user: user)
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
			data_point.numeric_sensor = sensor
			data_point.save!

      raise "Could not create statechange" unless StateChange.create(new_state: v, stateful_sensor: stateful_sensor)

			current_time = current_time - 1.hour
		end
	end
end
