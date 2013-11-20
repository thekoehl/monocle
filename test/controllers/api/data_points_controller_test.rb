require 'test_helper'

class Api::DataPointsControllerTest < ActionController::TestCase
  test "can create datapoints" do
    user = FactoryGirl.build(:user)
    user.save!
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
    user = FactoryGirl.build(:user)
    user.save!
    post :create, sensor: {name: "test"}
    assert_response 403
  end

  test 'it does throw 500 if no datapoint passed to create' do
    user = FactoryGirl.build(:user)
    user.save!
    post :create, {
                     sensor: {name: "test", units: "cats/second"},
                     api_key: user.api_key,
                  }
    assert_response 500
    body = JSON.parse(response.body)
    assert body['messages'][0] == 'You must pass a datapoint'
  end

end
