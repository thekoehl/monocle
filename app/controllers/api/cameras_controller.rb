class Api::CamerasController < Api::BaseController
  
  def create
    validate_create_params

    camera = create_camera_from_params

    return render json: json_success
  end

private

  def create_camera_from_params
    camera = current_user.cameras.find_or_create_by(name: params[:camera][:name])
    camera.name =  params[:camera][:name]
    camera.latest_image = params[:camera][:latest_image]
    camera.save!

    return camera
  end

  def validate_create_params
    raise "You must pass a camera"               unless params[:camera]
    raise "You must pass a camera[latest_image]" unless params[:camera][:latest_image]
    raise "You must pass a camera[name]"         unless params[:camera][:name]
  end

end
