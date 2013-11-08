class Api::DataPointsController < Api::BaseController
  before_filter :load_and_authenticate_api_user!

  def create
    begin
      raise "No sensor name passed" unless params[:sensor][:name]
      raise "No sensor units passed" unless params[:sensor][:units]
      raise "No datapoint value passed" unless params[:data_point][:value]

      sensor = Sensor.find_or_create_by(name: params[:sensor][:name], user_id: @current_user.id)
      sensor.units = params[:sensor][:units]

      sensor.save!

      data_point = DataPoint.new
      data_point.sensor = sensor
      data_point.value = params[:data_point][:value]
      data_point.save!

      return render json: json_success
    rescue Exception => ex
      return render json: json_failure(ex.message), status: 500
    end
  end
end