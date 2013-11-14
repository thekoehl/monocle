require 'test_helper'

class Api::CameraEventsControllerTest < ActionController::TestCase
  test "can upload event recording" do
  	user = get_valid_user
  	test_swf = fixture_file_upload('files/test.swf', 'application/shockwave')
  	post :create, {camera_event: {location: "event test"}, api_key: user.api_key, event_recording: test_swf}, format: :json
  	assert_response :success
  	assert CameraEvent.where(location: "event test").count == 1
  end

  def get_valid_user
  	user = User.new(email: 'test@test.com', password: 'aserfAWERAErrfser')
    user.save!
    return user
  end
end
