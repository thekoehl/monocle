class Api::SensorsController < Api::BaseController

  include Chartable

#  skip_before_filter :load_and_authenticate_api_user!
#  before_filter :authenticate_user!
  def index
    @sensors = current_user.sensors
  end

  def show
    @sensor = current_user.sensors.where(id: params[:id]).first
    raise ActiveRecord::NotFound unless @sensor
    @x_axis_labels = self.x_axis_labels
    @values = self.values
  end

end
