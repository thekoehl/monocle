require 'test_helper'

class CameraEventsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  test 'it can list camera events' do
    user = FactoryGirl.create(:user)
    camera_event = FactoryGirl.create(:camera_event, user: user)

    sign_in user

    get :index
    assert_response 200
  end

  test 'it can destroy all camera events' do
    user = FactoryGirl.create(:user)
    camera_event = FactoryGirl.create(:camera_event, user: user)
    
    user.reload
    assert user.camera_events.count == 1

    sign_in user

    post :destroy_all
    assert_response 302

    user.reload
    assert user.camera_events.count == 0
  end

end
