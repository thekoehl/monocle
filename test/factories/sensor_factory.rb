FactoryGirl.define do
  factory :sensor do
    name 'Test Sensor'
		user
    units 'Cats/s'
  end
end
