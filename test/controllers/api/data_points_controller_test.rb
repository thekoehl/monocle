require 'test_helper'

class Api::DataPointsControllerTest < ActionController::TestCase
  test "can create datapoints" do
    user = get_valid_user()
    post :create, {
                     sensor: {name: "test", units: "cats/second"},
                     api_key: user.api_key,
                     data_point: {value: 5}
                  }
    assert_response :success
    assert Sensor.count == 1
    assert DataPoint.count == 1
  end

  test "does deny access if improper api_key" do
    user = get_valid_user()
    post :create, sensor: {name: "test"}
    assert_response 403
  end

  def get_valid_user
    user = User.new(email: 'test@test.com', password: 'aserfAWERAErrfser')
    user.save!
    return user
  end

end
