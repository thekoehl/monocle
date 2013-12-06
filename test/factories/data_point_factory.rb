FactoryGirl.define do
	factory :data_point do
		value 5

    after(:build) { |object| object.numeric_sensor ||= FactoryGirl.build(:numeric_sensor) }
	end
end
