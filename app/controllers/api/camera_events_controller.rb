class Api::CameraEventsController < Api::BaseController
	before_filter :load_and_authenticate_api_user!
	protect_from_forgery :except => :create # This is meant to be called from the outside

	def create
		validate_create_params

		@camera_event = CameraEvent.new(location: params[:camera_event][:location])
		@camera_event.user = @current_user
		@camera_event.event_recording = params[:event_recording]
		@camera_event.save!

		render json: json_success
	end

	def destroy_all
		@current_user.camera_events.destroy_all
		return render json: json_success
	end

	def index
		@camera_events = @current_user.camera_events.order("created_at DESC")
	end

private

	def validate_create_params
		raise "No camera event passed" unless params[:camera_event]
		raise "No location passed for the camera event" unless params[:camera_event][:location]
		raise "No recording passed for the camera event" unless params[:event_recording]
	end

end
