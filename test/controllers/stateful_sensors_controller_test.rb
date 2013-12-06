require 'test_helper'

class StatefulSensorsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  test 'it can list stateful sensors' do
    user = FactoryGirl.create(:user)
    sensor = FactoryGirl.create(:stateful_sensor, user: user)
    state_change = FactoryGirl.create(:state_change, stateful_sensor: sensor)

    sign_in user

    get :index

    assert_response 200
  end
end
