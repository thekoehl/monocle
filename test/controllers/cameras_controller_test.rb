require 'test_helper'

class CamerasControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  test 'it can list cameras' do
    user = FactoryGirl.create(:user)
    camera = FactoryGirl.create(:camera, user: user)

    sign_in user

    get :index

    assert_response 200
  end
end
