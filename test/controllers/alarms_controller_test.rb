require 'test_helper'

class AlarmsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  test 'it can create new alarms' do
    current_alarms_count = Alarm.count

    user = FactoryGirl.create(:user)
    sensor = FactoryGirl.create(:numeric_sensor, user: user)

    sign_in user

    post :create, {
      alarm: {
        alarm_type: Alarm::ALARM_TYPES[:low_level],
        trigger_value: 5,
        sensor_id: sensor.id
      }
    }

    assert Alarm.count == current_alarms_count + 1
  end

  test 'it does redisplay the new form if bad params to create' do
    sensor = FactoryGirl.create(:numeric_sensor)
    sign_in sensor.user

    post :create, {alarm: { trigger_value: 5}}

    assert_response 200
    assert_template :new
  end

  test 'it cannot create alarms that belong to other users sensors' do
    current_alarms_count = Alarm.count
    user = FactoryGirl.create(:user)
    second_user = FactoryGirl.create(:user)
    sensor = FactoryGirl.create(:numeric_sensor, user: user)

    sign_in second_user

    post :create, {
      alarm: {
        alarm_type: Alarm::ALARM_TYPES[:low_level],
        trigger_value: 5,
        sensor_id: sensor.id
      }
    }

    assert Alarm.count == current_alarms_count
  end

  test 'it can destroy alarms' do
    alarm = FactoryGirl.create(:alarm)

    sign_in alarm.sensor.user

    delete :destroy, {
      id: alarm.id
    }

    assert_response 302
    assert Alarm.where(id: alarm.id).length == 0
  end

  test 'it can list alarms' do
    user = FactoryGirl.create(:user)
    sensor = FactoryGirl.create(:numeric_sensor, user: user)
    alarm = FactoryGirl.create(:alarm, sensor: sensor)

    sign_in user

    get :index

    assert_response 200
  end

  test 'it can update alarms' do
    user = FactoryGirl.create(:user)
    sensor = FactoryGirl.create(:numeric_sensor, user: user)
    alarm = FactoryGirl.create(:alarm, sensor: sensor, user: user)

    sign_in user

    put :update, {
      id: alarm.id,
      alarm: {
        trigger_value: 452
      }
    }
    assert_response 302
    alarm.reload
    assert alarm.trigger_value == 452
  end

  test 'it does redisplay the update form if bad params to update' do
    alarm = FactoryGirl.create(:alarm)
    sign_in alarm.sensor.user

    post :update, {id: alarm.id, alarm: { trigger_value: nil, sensor: nil}}

    assert_response 200
    assert_template :edit
  end

  test 'it can render the new form' do
    user = FactoryGirl.create(:user); sign_in(user);

    get :new

    assert_response 200
  end

  test 'it can render the update form' do
    alarm = FactoryGirl.create(:alarm)
    sign_in(alarm.sensor.user);

    get :edit, {id: alarm.id}

    assert_response 200
  end
end
