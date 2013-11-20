FactoryGirl.define do
	factory :sensor do
		name 'Test Sensor'
		units 'Cats/s'
	end

	factory :sensor_with_user, class: Sensor do
		name 'Test Sensor with User'
		units "Users/s"
		user { FactoryGirl.build(:user) }
	end
end