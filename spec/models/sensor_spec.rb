require 'spec_helper'
describe Sensor, type: :model do
	let (:sensor) {
		s = Sensor.new
		s.name = "Test Sensor"
		d = DataPoint.new({ value: 1, units: 'F', reporter: 'test reporter'}); d.sensor = s; d.save!
		d = DataPoint.new({ value: 4, units: 'F', reporter: 'test reporter'}); d.sensor = s; d.save!
		d = DataPoint.new({ value: 3, units: 'F', reporter: 'test reporter'}); d.sensor = s; d.save!
		d = DataPoint.new({ value: 2, units: 'F', reporter: 'test reporter'}); d.sensor = s; d.save!
		s.save!

		return s
	}
	describe '.data_points' do
		it 'can recalculate maximum value' do
			sensor.recalculate_maximum_value!
			sensor.maximum_value.should eq(4)
		end

		it 'can calculate percentage of last value' do
			sensor.recalculate_maximum_value!
			sensor.last_value_as_percentage.should eq(50)
		end
	end
end