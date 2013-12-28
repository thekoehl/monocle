require 'test_helper'

class DashboardsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  test 'it can display the default scifi dashboard' do
    user = FactoryGirl.create(:user)
    sign_in user

    get :scifi

    assert_response 200
  end

end
