require 'test_helper'

class Api::CamerasControllerTest < ActionController::TestCase
  test "can upload snapshots" do
  	user = get_valid_user
  	test_image = fixture_file_upload('files/test.jpg', 'image/jpg')
  	post :create, {camera: {name: "snapshot test", latest_snapshot: test_image}, api_key: user.api_key}, format: :json
  	assert_response :success
  	assert Camera.where(name: "snapshot test").count == 1
  end

  def get_valid_user
  	user = User.new(email: 'test@test.com', password: 'aserfAWERAErrfser')
    user.save!
    return user
  end
end