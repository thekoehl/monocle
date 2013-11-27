require 'test_helper'

class SensorTest < ActiveSupport::TestCase
  test "has_many data points" do
    sensor = FactoryGirl.build(:sensor)
    sensor.data_points << FactoryGirl.build(:data_point)
    sensor.save!
    assert sensor.data_points.length == 1
  end

  test 'can get last_value' do
    r = Random.new
    sensor = FactoryGirl.create(:sensor)
    ts = Time.now - 7.hours
    d = nil
    Timecop.freeze do
      5.times.each do
        Timecop.travel ts
        FactoryGirl.create(:data_point, sensor: sensor, value: Random.rand(0..55))
        ts = ts + 1.hour
      end
      d = FactoryGirl.create(:data_point, sensor: sensor, value: Random.rand(0..55))
    end

    sensor.reload
    assert sensor.last_value == d.value
  end
end
