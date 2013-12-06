class Api::AlarmsController < Api::BaseController
  before_filter :load_and_authenticate_api_user!

  respond_to :json

  def create
    validate_create_params
    @sensor = @current_user.numeric_sensors.find(params[:alarm][:sensor_id])
    raise "User to sensor mismatch" if @sensor.nil?

    @alarm = Alarm.new alarm_params
    @alarm.save!

    render json: json_success
  end

  def index
    @alarms = @current_user.alarms
  end

private

  def alarm_params
    params.require(:alarm).permit(:alarm_type, :sensor_id, :trigger_value, :user_id)
  end

  def validate_create_params
    raise "You must pass an alarm" unless params[:alarm]
    raise "You must pass an alarm[sensor_id]" unless params[:alarm][:sensor_id]
  end

end
