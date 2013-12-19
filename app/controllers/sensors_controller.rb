class SensorsController < ActionController::Base
  layout 'application'

  before_filter :authenticate_user!

  def index; end

  def scifi
    @cameras = current_user.cameras
    @numeric_sensors = current_user.numeric_sensors.order('name ASC')
    @stateful_sensors = current_user.stateful_sensors.order('name ASC')
    render layout: false
  end

end
