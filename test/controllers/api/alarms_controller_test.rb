require 'test_helper'

class Api::AlarmsControllerTest < ActionController::TestCase
	test "can create new alarms" do
		current_alarms = Alarm.count

		@sensor = FactoryGirl.build(:sensor_with_user)
		@sensor.save!

		post :create, {
			alarm: {
				alarm_type: Alarm::ALARM_TYPES[:low_level],
				trigger_value: 5,
				sensor_id: @sensor.id
			},
			api_key: @sensor.user.api_key
		}
		assert Alarm.count == current_alarms + 1
	end
end