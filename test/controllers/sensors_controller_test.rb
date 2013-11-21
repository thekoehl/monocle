require 'test_helper'

class AlarmsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  test 'it can list sensors' do
    user = FactoryGirl.create(:user)
    sign_in user

    get :index

    assert_response 200
  end

end