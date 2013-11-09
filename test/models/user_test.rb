require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "has_many cameras" do
    user = User.new
    user.cameras << Camera.new(name: 'test')
    assert user.cameras.length == 1
  end
  test "has_many sensors" do
    user = User.new
    user.sensors << Sensor.new(name: 'test', units: 'tests/s')
    assert user.sensors.length == 1
  end
  test "assigns api_key if not present" do
    user = get_valid_user()
    user.save!

    assert user.api_key != nil && user.api_key != ""
  end

  def get_valid_user
    return User.new(email: 'test@test.com', password: 'aserfAWERAErrfser')
  end
end
