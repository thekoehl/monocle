class NumericSensor < Sensor
  
  #################
  # Relationships #
  #################
  
  has_many :data_points, dependent: :destroy

  ###############
  # Validations #
  ###############

  validates :units, presence: true

	####################
	# Instance Methods #
	####################

	def last_value
    @last_value ||= self.data_points.count > 0 ? self.data_points.order("created_at DESC").first.value : 0
    return @last_value
	end

  def max_value
    @max_value ||= self.data_points.where('created_at > ?', Time.now-7.days).maximum(:value).to_f
    return @max_value
  end

  def current_percentage_value
    return 0 if max_value == 0
    return ((last_value / max_value) * 100).to_i
  end

end
