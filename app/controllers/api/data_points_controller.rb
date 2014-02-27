class Api::DataPointsController < Api::BaseController
  before_filter :load_and_authenticate_api_user!

  def create
    validate_create_params

    sensor = create_sensor_from_params
    data_point = create_data_point_from_params(sensor)

    return render json: json_success
  end

private

  def create_data_point_from_params sensor
    data_point = DataPoint.new(sensor: sensor, value: params[:data_point][:value])
    data_point.save!

    return data_point
  end

  def create_sensor_from_params
    sensor = Sensor.find_or_create_by(name: params[:sensor][:name], user_id: @current_user.id)
    sensor.units =  params[:sensor][:units]
    sensor.save!

    return sensor
  end

  def validate_create_params
    raise "You must pass a datapoint" unless params[:data_point]
    raise "You must pass a datapoint[value]" unless params[:data_point][:value]
    raise "You must pass a sensor" unless params[:sensor]
    raise "You must pass a sensor[name]" unless params[:sensor][:name]
  end
end
