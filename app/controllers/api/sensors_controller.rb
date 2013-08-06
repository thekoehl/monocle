class Api::SensorsController < Api::BaseController
	before_filter :load_and_authenticate_api_user!

	def show
		@sensor = @current_user.sensors.find(params[:id])
		return render json: { sensor: @sensor,
			                    last_value: @sensor.data_points.last.value }
	end
end