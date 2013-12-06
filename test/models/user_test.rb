require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "has_many cameras" do
    user = FactoryGirl.build(:user)
    user.cameras << Camera.new(name: 'test')
    assert user.cameras.length == 1
  end
  
  test "has_many numeric_sensors" do
    user = FactoryGirl.build(:user)
    user.numeric_sensors << NumericSensor.new(name: 'test', units: 'tests/s')
    assert user.numeric_sensors.length == 1
  end
  
  test "has_many stateful_sensors" do
    user = FactoryGirl.build(:user)
    user.numeric_sensors << NumericSensor.new(name: 'test', units: 'tests/s')
    assert user.numeric_sensors.length == 1
  end

  test "assigns api_key if not present" do
    user = FactoryGirl.build(:user)
    user.save!

    assert user.api_key != nil && user.api_key != ""
  end
end
