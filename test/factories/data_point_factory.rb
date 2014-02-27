FactoryGirl.define do
	factory :data_point do
		value 5

    after(:build) { |object| object.sensor ||= FactoryGirl.build(:sensor) }
	end
end
