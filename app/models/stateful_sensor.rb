class StatefulSensor < Sensor

  #################
  # Relationships #
  #################

  has_many :state_changes, dependent: :destroy

  ####################
  # Instance Methods #
  ####################

def last_state
    @last_state ||= self.state_changes.last.new_state
    return @last_state
  end

end
