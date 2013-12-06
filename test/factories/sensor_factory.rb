FactoryGirl.define do
  factory :sensor do
    name 'Test Sensor'
		user
  end
	factory :numeric_sensor, parent: :sensor, class: :numeric_sensor do
		units 'Cats/s'
	end
	factory :stateful_sensor, parent: :sensor, class: :stateful_sensor do
	end

end
