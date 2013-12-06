require 'test_helper'

class Api::SensorsControllerTest < ActionController::TestCase
  test "can get json" do
    sensor = nil
    new_time = Time.local(2008, 9, 1, 12, 0, 0)
    Timecop.freeze(new_time) do
      sensor = get_valid_sensor
      get :index, api_key: sensor.user.api_key, format: :json
    end
    body = JSON.parse(response.body)

    assert body['sensors'][0]['name'] = sensor.name
    assert body['sensors'][0]['units'] = sensor.units
    assert body['sensors'][0]['data_points_hourly'][0]["value"] == 35
    assert body['sensors'][0]['data_points_daily'][0]["value"] == 85
    assert body['sensors'][0]['data_points_monthly'][0]["value"] == 85
  end

  test 'can destroy sensor' do
    sensor = get_valid_sensor
    delete :destroy, id: sensor.id, api_key: sensor.user.api_key, format: :json
    assert_response 200
    assert NumericSensor.where(id: sensor.id).count == 0
  end

  def get_valid_sensor
    user = User.new(email: 'test@test.com', password: 'aserfAWERAErrfser')
    user.save!

    sensor = NumericSensor.new(name: "Test Sensor", units: "cats/sec")
    sensor.user = user
    sensor.save!

    data_point = DataPoint.new(value: 35)
    data_point.numeric_sensor = sensor
    data_point.save!

    Timecop.travel(Time.now + 3.hours)
    data_point = DataPoint.new(value: 135)
    data_point.numeric_sensor = sensor
    data_point.save!

    return sensor
  end
end
