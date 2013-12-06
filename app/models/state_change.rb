class StateChange < ActiveRecord::Base

  #################
  # Relationships #
  #################

  belongs_to :stateful_sensor

  ###############
  # Validations #
  ###############

  validates :stateful_sensor, presence: true
  validates :new_state, presence: true

  #############
  # Callbacks #
  #############

  before_validation :assign_previous_state
  def assign_previous_state
    return true if self.stateful_sensor.nil? # The validation will stop the save
    return true if self.stateful_sensor.state_changes.count == 0 # No previous one to use

    self.old_state = self.stateful_sensor.state_changes.last.new_state

    return true
  end

end
