require 'test_helper'

class Api::StateChangesControllerTest < ActionController::TestCase
  test "can create state_changes" do
    user = FactoryGirl.build(:user)
    user.save!
    post :create, {
                     sensor: {name: "test"},
                     api_key: user.api_key,
                     state_change: {new_state: 5}
                  }
    assert_response :success
    assert Sensor.count == 1
    assert StateChange.count == 1
  end

  test "does deny access if improper api_key" do
    user = FactoryGirl.build(:user)
    user.save!
    post :create, sensor: {name: "test"}
    assert_response 403
  end

  test 'it does throw 500 if no state_change passed to create' do
    user = FactoryGirl.build(:user)
    user.save!
    post :create, {
                     sensor: {name: "test"},
                     api_key: user.api_key,
                  }
    assert_response 500
    body = JSON.parse(response.body)
    assert body['messages'][0] == 'You must pass a state change'
  end

end
