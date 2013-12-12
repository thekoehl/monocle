class SensorsController < ActionController::Base
  layout 'application'

  before_filter :authenticate_user!

  def index; end

  def scifi
    @cameras = current_user.cameras
    @numeric_sensors = current_user.numeric_sensors
    @stateful_sensors = current_user.stateful_sensors
    render layout: false
  end

  def show
    @sensor = current_user.numeric_sensors.find_by_id params[:id]
    raise "Could not locate specified sensor" unless @sensor
  end

end
