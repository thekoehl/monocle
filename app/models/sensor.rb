class Sensor < ActiveRecord::Base
  
  #################
  # Relationships #
  #################

  belongs_to :user

  has_many :alarms, dependent: :destroy
  has_many :data_points, dependent: :destroy

  ###############
  # Validations #
  ###############

  validates :name, presence: true
  validates :units, presence: true

	####################
	# Instance Methods #
	####################

	def last_value
		return 0 if self.data_points.count == 0
		return self.data_points.order("created_at DESC").first.value
	end

end
