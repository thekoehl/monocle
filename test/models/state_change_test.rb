require 'test_helper'

class StateChangeTest < ActiveSupport::TestCase

  # Enforcing actual state change
  test 'it wont save if this is a duplicate state change' do
    sensor = FactoryGirl.create(:stateful_sensor)
    state_change1 = FactoryGirl.create(:state_change, stateful_sensor: sensor, new_state: 'state 1')
    state_change = StateChange.new(stateful_sensor: sensor, new_state: 'state 1')
    assert state_change.save == false
  end

  # Previous State Assignment

  test 'it assigns previous state when one is available' do
    sensor = FactoryGirl.create(:stateful_sensor)
    state_change1 = FactoryGirl.create(:state_change, stateful_sensor: sensor, new_state: 'state 1')
    state_change2 = FactoryGirl.create(:state_change, stateful_sensor: sensor, new_state: 'state 2')
    state_change3 = FactoryGirl.create(:state_change, stateful_sensor: sensor, new_state: 'state 3')

    assert state_change1.old_state == nil
    assert state_change2.old_state == 'state 1'
    assert state_change3.old_state == 'state 2'

  end

end
