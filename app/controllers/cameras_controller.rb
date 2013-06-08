class CamerasController < ApplicationController
  before_filter :authenticate_user!, except: [:update]
  def index
    @cameras = current_user.cameras
  end

  # Example CURL Test:
  #    curl -X PUT -F "camera[latest_snapshot]=@02-20130606191145-01.jpg"  http://192.168.1.102:3000/cameras/Upstairs%20Camera\?user\\[api_key\\]=3a852127-146a-4b42-811f-3f6702777b1e
  def update
    begin
      @user = User.find_by_api_key params[:user][:api_key]
      raise "Non-existant user[api_key] passed." if @user == nil

      @camera = @user.cameras.find_or_create_by_title params[:id]
      raise "Something went totally wrong while trying to locate that camera." if @camera.nil?



      @camera.title = params[:id]
      if @camera.update_attributes params[:camera]
        render json: {success: true, data_point: @data_point, sensor: @sensor}
      else
        render json: {success: false, errors: @camera.errors}
      end
    rescue Exception => ex
      render :json => {success: false, message: ex.message}
    end
  end
end
