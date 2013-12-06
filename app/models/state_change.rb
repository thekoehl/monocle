class StateChange < ActiveRecord::Base

  #################
  # Relationships #
  #################

  belongs_to :stateful_sensor

  ###############
  # Validations #
  ###############

  validates :new_state, presence: true

end
