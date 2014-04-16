class Api::SensorsController < Api::BaseController
  skip_before_filter :load_and_authenticate_api_user!
  before_filter :authenticate_user!
  def index
    @sensors = current_user.sensors
  end
end