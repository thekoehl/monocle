class StatefulSensor < Sensor

  #################
  # Relationships #
  #################

  has_many :state_changes, dependent: :destroy

end
