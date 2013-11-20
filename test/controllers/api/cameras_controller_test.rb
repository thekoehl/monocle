require 'test_helper'

class Api::CamerasControllerTest < ActionController::TestCase
  test "can upload snapshots" do
  	user = FactoryGirl.build(:user)
    user.save!

  	test_image = fixture_file_upload('files/test.jpg', 'image/jpg')
  	post :create, {camera: {name: "snapshot test"}, api_key: user.api_key, latest_snapshot: test_image}, format: :json
  	assert_response :success
  	assert Camera.where(name: "snapshot test").count == 1
  end

  test "can get cameras" do
    user = FactoryGirl.build(:user)
    user.save!

    test_image = fixture_file_upload('files/test.jpg', 'image/jpg')
    post :create, {camera: {name: "snapshot test"}, api_key: user.api_key, latest_snapshot: test_image}, format: :json
    assert_response :success
    get :index, api_key: user.api_key, format: :json
    body = JSON.parse(response.body)
    assert body['cameras'][0]['name'] = "snapshot test"
    assert body['cameras'][0]['latest_snapshot_url'].include?('test')
  end

  test "does throw exception if no camera is passed" do
    user = FactoryGirl.build(:user)
    user.save!

    test_image = fixture_file_upload('files/test.jpg', 'image/jpg')
    post :create, {api_key: user.api_key, latest_snapshot: test_image}, format: :json
    assert_response 500
    body = JSON.parse(response.body)
    assert body['messages'][0] == 'No camera passed'
  end
end