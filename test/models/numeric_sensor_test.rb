require 'test_helper'

class NumericSensorTest < ActiveSupport::TestCase

  ####################
  # Data Aggregation #
  ####################

  def create_sensor_with_range_array range_array
    sensor = FactoryGirl.create(:numeric_sensor)
    range_array.each do |i|
      FactoryGirl.create(:data_point, numeric_sensor: sensor, value: i)
    end
    return sensor
  end

  test "it can determine its max value" do
    sensor = create_sensor_with_range_array [3, 55, 2]
    assert sensor.max_value == 55
  end

  test 'it can determine its min value' do
    sensor = create_sensor_with_range_array [3, 1, 2]
    assert sensor.min_value == 1
  end

  test 'it can determine the trend direction upwardly' do
    sensor = create_sensor_with_range_array [1,2,3]
    assert sensor.trend_direction == 1
  end

  test 'it can determine the trend direction downward' do
    sensor = create_sensor_with_range_array [3,2,1]
    assert sensor.trend_direction == -1
  end

  test 'it can determine the trend direction is stable' do
    sensor = create_sensor_with_range_array [3,3,3]
    assert sensor.trend_direction == 0
  end

  test 'it can return the proper arrow based on direction' do
    sensor = create_sensor_with_range_array [1,2,3]
    assert sensor.trend_direction_arrow == NumericSensor::TREND_ARROW_UP

    sensor = create_sensor_with_range_array [3,3,3]
    assert sensor.trend_direction_arrow == NumericSensor::TREND_ARROW_STABLE

    sensor = create_sensor_with_range_array [3,2,1]
    assert sensor.trend_direction_arrow == NumericSensor::TREND_ARROW_DOWN

  end

  test 'it can determine the current percentage value' do
    sensor = create_sensor_with_range_array [100,0,50]
    assert sensor.current_percentage_value == 50
  end

  ################
  # Associations #
  ################

  test "has_many data points" do
    sensor = FactoryGirl.build(:numeric_sensor)
    sensor.data_points << FactoryGirl.build(:data_point)
    sensor.save!
    assert sensor.data_points.length == 1
  end

  ####################
  # Instance Methods #
  ####################

  test 'can get last_value' do
    r = Random.new
    sensor = FactoryGirl.create(:numeric_sensor)
    ts = Time.now - 7.hours
    d = nil
    Timecop.freeze do
      5.times.each do
        Timecop.travel ts
        FactoryGirl.create(:data_point, numeric_sensor: sensor, value: Random.rand(0..55))
        ts = ts + 1.hour
      end
      d = FactoryGirl.create(:data_point, numeric_sensor: sensor, value: Random.rand(0..55))
    end

    sensor.reload
    assert sensor.last_value == d.value
  end
end
