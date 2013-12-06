class StatefulSensor < Sensor

  #################
  # Relationships #
  #################

  has_many :state_changes, dependent: :destroy

  ####################
  # Instance Methods #
  ####################
  
  def last_state
    return self.state_changes.last.new_state
  end

end
