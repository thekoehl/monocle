require 'test_helper'

class SensorTest < ActiveSupport::TestCase
  test "has_many sensors" do
    sensor = Sensor.new(name: 'Test Sensor', units: 'cats/s')
    sensor.data_points << get_valid_data_point()
    sensor.save!
    assert sensor.data_points.length == 1
  end

  def get_valid_data_point
    return DataPoint.new(value: 5, hourly_segmentation: Time.now, daily_segmentation: Time.now, monthly_segmentation: Time.now)
  end
end
