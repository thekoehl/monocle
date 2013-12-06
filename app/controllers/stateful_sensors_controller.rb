class StatefulSensorsController < ActionController::Base
  layout 'application'

  before_filter :authenticate_user!

  def index
    @stateful_sensors = current_user.stateful_sensors.order('name ASC')
  end

end
