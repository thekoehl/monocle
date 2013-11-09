require 'jbuilder'
class Api::SensorsController < Api::BaseController
  before_filter :load_and_authenticate_api_user!

  respond_to :json

  def index
    @sensors = @current_user.sensors
  end

end
