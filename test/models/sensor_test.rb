require 'test_helper'

class SensorTest < ActiveSupport::TestCase
  test "has_many data points" do
    sensor = FactoryGirl.build(:sensor)
    sensor.data_points << FactoryGirl.build(:data_point)
    sensor.save!
    assert sensor.data_points.length == 1
  end
end
