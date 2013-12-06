class StateChange < ActiveRecord::Base

  #################
  # Relationships #
  #################

  belongs_to :sensor

  ###############
  # Validations #
  ###############

  validates :value, presence: true

end
