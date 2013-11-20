FactoryGirl.define do
	factory :alarm_with_sensor, class: Alarm do
		alarm_type Alarm::ALARM_TYPES[:low_level]
		trigger_value 5
		sensor { FactoryGirl.build(:sensor_with_user) }
	end
end