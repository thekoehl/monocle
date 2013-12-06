FactoryGirl.define do
  factory :state_change do
    new_state 'New Value'

    after(:build) { |object| object.stateful_sensor ||= FactoryGirl.build(:stateful_sensor) }
  end
end
