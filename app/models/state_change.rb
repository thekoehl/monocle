class StateChange < ActiveRecord::Base

  #################
  # Relationships #
  #################

  belongs_to :stateful_sensor

  ##########
  # Scopes #
  ##########
  
  scope :a_few, -> { limit(15).order("created_at DESC") }

  ###############
  # Validations #
  ###############

  validates :stateful_sensor, presence: true
  validates :new_state, presence: true

  #############
  # Callbacks #
  #############

  # This is meant to just be state changes; dont save if this is a dupe
  #
  # Depends upon assign_previous_state being executed first during the 
  # before_validation callback.
  before_save :ensures_not_duplicate
  def ensures_not_duplicate
    return true if self.stateful_sensor.nil? # The validation will stop the save
    return true if self.stateful_sensor.state_changes.count == 0 # No previous one to use

    return self.old_state != self.new_state
  end

  before_validation :assign_previous_state
  def assign_previous_state
    return true if self.stateful_sensor.nil? # The validation will stop the save
    return true if self.stateful_sensor.state_changes.count == 0 # No previous one to use

    self.old_state = self.stateful_sensor.state_changes.last.new_state

    return true
  end

end
