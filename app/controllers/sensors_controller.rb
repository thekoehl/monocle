class SensorsController < ActionController::Base
  layout 'application'

  before_filter :authenticate_user!

  def index; end

  def show
    @sensor = current_user.numeric_sensors.find_by_id params[:id]
    raise "Could not locate specified sensor" unless @sensor
  end

end
