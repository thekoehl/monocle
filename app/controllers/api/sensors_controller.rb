require 'jbuilder'
class Api::SensorsController < Api::BaseController
  before_filter :load_and_authenticate_api_user!

  def index
    @sensors = @current_user.sensors
    j = Jbuilder.encode do |json|
      json.status "success"
      json.sensors @sensors do |sensor|
        json.name sensor.name
        json.units sensor.units
        json.data_points_hourly sensor.data_points.segmented('hourly').average(:value) do |dp|
          json.id dp[0]
          json.value dp[1]
        end
        json.data_points_daily sensor.data_points.segmented('daily').average(:value) do |dp|
          json.id dp[0]
          json.value dp[1]
        end
        json.data_points_monthly sensor.data_points.segmented('monthly').average(:value) do |dp|
          json.id dp[0]
          json.value dp[1]
        end
      end
    end
    return render json: j
  end

end
