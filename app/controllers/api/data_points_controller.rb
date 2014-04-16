class Api::DataPointsController < Api::BaseController
  # data_point[value] = 2.25
  # data_point[logged_at] = 2014-04-15 20:48:24 -0500
  # sensor[name] = Test Sensor
  # sensor[units] = F
  def create
    validate_create_params

    group = create_group_from_params
    sensor = create_sensor_from_params(group)
    data_point = create_data_point_from_params(sensor)

    return render json: json_success
  end

private

  def create_data_point_from_params sensor
    data_point = DataPoint.new(sensor: sensor, value: params[:data_point][:value], logged_at: params[:data_point][:logged_at])
    data_point.save!

    return data_point
  end

  def create_group_from_params
    group = Group.find_or_create_by(name: params[:group][:name], user_id: @current_user.id)
  end

  def create_sensor_from_params group
    sensor = Sensor.find_or_create_by(name: params[:sensor][:name], group_id: group.id)
    sensor.units =  params[:sensor][:units]
    sensor.save!

    return sensor
  end

  def validate_create_params
    raise "You must pass a datapoint" unless params[:data_point]
    raise "You must pass a datapoint[value]" unless params[:data_point][:value]
    raise "You must pass a sensor" unless params[:sensor]
    raise "You must pass a sensor[name]" unless params[:sensor][:name]
    raise "You must pass a sensor[units]" unless params[:sensor][:units]
  end
end