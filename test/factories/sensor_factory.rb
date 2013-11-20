FactoryGirl.define do
	factory :sensor do
		name 'Test Sensor'
		units 'Cats/s'
		user
	end
end