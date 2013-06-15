class CameraEventsController < ApplicationController

	# Example CURL Test:
  #    curl -X PUT -F "camera_event[video]=@02-20130606191145-01.swf"  http://192.168.1.102:3000/camera_events/Upstairs%20Camera\?user\\[api_key\\]=3a852127-146a-4b42-811f-3f6702777b1e
  def create
    begin
      @user = User.find_by_api_key params[:user][:api_key]
      raise "Non-existant user[api_key] passed." if @user == nil

      @camera = @user.cameras.find_by_title params[:camera_title]
      raise "Something went totally wrong while trying to locate that camera." if @camera.nil?

      @camera_event = @camera.camera_events.build params[:camera_event]

      if @camera_event.save
        render json: {success: true, camera_event: @camera_event}
      else
        render json: {success: false, errors: @camera_event.errors}
      end
    rescue Exception => ex
      render :json => {success: false, message: ex.message}
    end
  end

end
