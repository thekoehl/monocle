class Api::CamerasController < Api::BaseController
	before_filter :load_and_authenticate_api_user!
	protect_from_forgery :except => :create # This is meant to be called from the outside

	# This really is a create or update; but this is easiest for API
	# users to use.
	def create
		begin
			validate_create_params

			@camera = @current_user.cameras.find_or_create_by(name: params[:camera][:name], user_id: @current_user)
			@camera.latest_snapshot = params[:latest_snapshot]
			@camera.save!

			render json: json_success
		rescue Exception => ex
			return render json: json_failure(ex.message), status: 500
		end
	end

	def index
		@cameras = @current_user.cameras
	end

private

	def validate_create_params
		raise "No camera passed" unless params[:camera]
		raise "No name passed for the camera" unless params[:camera][:name]
	end

end
