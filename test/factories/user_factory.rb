FactoryGirl.define do
	factory :user do
		sequence(:email) { |n| "test+#{n}@test.com" }
		password 'SAEasearAER'
	end
end