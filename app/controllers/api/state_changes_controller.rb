class Api::StateChangesController < Api::BaseController
  before_filter :load_and_authenticate_api_user!

  def create
    validate_create_params

    sensor = create_sensor_from_params
    create_state_change_from_params(sensor)

    return render json: json_success
  end

private

  def create_state_change_from_params sensor
    state_change = StateChange.new(stateful_sensor: sensor, new_state: params[:state_change][:new_state])
    state_change.save!
  end

  def create_sensor_from_params
    sensor = StatefulSensor.find_or_create_by(name: params[:sensor][:name], user_id: @current_user.id)
    sensor.save!

    return sensor
  end

  def validate_create_params
    raise "You must pass a state change" unless params[:state_change]
    raise "You must pass state_change[new_state]" unless params[:state_change][:new_state]
    raise "You must pass sensor" unless params[:sensor]
    raise "You must pass sensor[name]" unless params[:sensor][:name]
  end
end
