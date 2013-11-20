class Api::AlarmsController < Api::BaseController
	before_filter :load_and_authenticate_api_user!
	protect_from_forgery :except => :create # This is meant to be called from the outside

	def create
		begin
			@sensor = @current_user.sensors.find(params[:alarm][:sensor_id])
			raise "User to sensor mismatch" if @sensor.nil?

			@alarm = Alarm.new alarm_params
			@alarm.save!

			render json: json_success
		rescue Exception => ex
			return render json: json_failure(ex.message), status: 500
		end
	end

private

	def alarm_params
		params.require(:alarm).permit(:alarm_type, :sensor_id, :trigger_value, )
	end

end
