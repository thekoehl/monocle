class Sensor < ActiveRecord::Base
 
  #################
  # Relationships #
  #################

  belongs_to :user
  has_many :alarms, dependent: :destroy


  ###############
  # Validations #
  ###############

  validates :name, presence: true
  validates :type, presence: true

end
