class Api::SensorsController < Api::BaseController
  before_filter :load_and_authenticate_api_user!

  respond_to :json

  def destroy
    sensor = @current_user.numeric_sensors.find(params[:id])
    return render(json: json_failure("Could not locate specified sensor")) unless sensor
    success = sensor.destroy
    return render(json: json_success) if success
    # It really should never fall through
  end

  def index
    @sensors = @current_user.numeric_sensors.order(name: :asc)
  end

end
