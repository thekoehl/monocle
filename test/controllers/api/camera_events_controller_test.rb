require 'test_helper'

class Api::CameraEventsControllerTest < ActionController::TestCase
  test "can upload event recording" do
    user = FactoryGirl.build(:user)
    user.save!
  	test_swf = fixture_file_upload('files/test.swf', 'application/shockwave')
  	post :create, {camera_event: {location: "event test"}, api_key: user.api_key, event_recording: test_swf}, format: :json
  	assert_response :success
  	assert CameraEvent.where(location: "event test").count == 1
  end

  test 'does return 500 if event recording save fails' do
    user = FactoryGirl.build(:user)
    user.save!
    test_swf = fixture_file_upload('files/test.swf', 'application/shockwave')
    post :create, {api_key: user.api_key, event_recording: test_swf}, format: :json
    assert_response 500
    body = JSON.parse(response.body)
    assert body['messages'][0] == 'No camera event passed'
  end

  test "can get camera events" do
    user = FactoryGirl.build(:user)
    user.save!
    test_swf = fixture_file_upload('files/test.swf', 'application/shockwave')
  	post :create, {camera_event: {location: "event test"}, api_key: user.api_key, event_recording: test_swf}, format: :json
    assert_response :success

    get :index, api_key: user.api_key, format: :json

    body = JSON.parse(response.body)

    assert body['camera_events'][0]['location'] == "event test"
    assert body['camera_events'][0]['event_recording_url'].include?('test')
  end

  test "can destroy camera events" do
    user = FactoryGirl.build(:user)
    user.save!
    test_swf = fixture_file_upload('files/test.swf', 'application/shockwave')
    post :create, {camera_event: {location: "event test"}, api_key: user.api_key, event_recording: test_swf}, format: :json
    assert_response :success
    assert user.camera_events.count > 0

    post :destroy_all, api_key: user.api_key, format: :json

    body = JSON.parse(response.body)
    assert_response :success
    user.reload
    assert user.camera_events.count == 0
  end
end
