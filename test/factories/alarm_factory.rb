FactoryGirl.define do
	factory :alarm, class: Alarm do
		alarm_type Alarm::ALARM_TYPES[:low_level]
		trigger_value 5
		sensor
	end
end