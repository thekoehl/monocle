require 'test_helper'

class Api::SensorsControllerTest < ActionController::TestCase
  test "can get json" do
    sensor = get_valid_sensor
    get :index, api_key: sensor.user.api_key

    body = JSON.parse(response.body)
    assert body['sensors'][0]['name'] = sensor.name
    assert body['sensors'][0]['units'] = sensor.units
    assert body['sensors'][0]['data_points_hourly'][0]["value"] == "35.0"
    assert body['sensors'][0]['data_points_daily'][0]["value"] == "85.0"
    assert body['sensors'][0]['data_points_monthly'][0]["value"] == "85.0"
  end

  def get_valid_sensor
    user = User.new(email: 'test@test.com', password: 'aserfAWERAErrfser')
    user.save!

    sensor = Sensor.new(name: "Test Sensor", units: "cats/sec")
    sensor.user = user
    sensor.save!

    new_time = Time.local(2008, 9, 1, 12, 0, 0)
    Timecop.freeze(new_time) do
      data_point = DataPoint.new(value: 35)
      data_point.sensor = sensor
      data_point.save!

      Timecop.travel(new_time + 3.hours)
      data_point = DataPoint.new(value: 135)
      data_point.sensor = sensor
      data_point.save!
    end
    return sensor
  end
end