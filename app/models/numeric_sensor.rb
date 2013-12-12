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

  def min_value
    @min_value ||= self.data_points.where('created_at > ?', Time.now-7.days).minimum(:value).to_f
    return @min_value
  end
 
  def trend_direction
    return "NONE" if self.data_points.count <= 1
    prior_value = self.data_points.order('created_at DESC').take(2)[1].value
    if last_value < prior_value
      return "DOWN"
    elsif last_value > prior_value
      return "UP"
    else
      return "NONE"
    end
  end

  def trend_direction_arrow
    trend = trend_direction
    if trend == 'UP'
      return '&#x25B2;'
    elsif trend == 'DOWN'
      return '&#x25BC;'
    elsif trend == 'NONE'
      return '&#x25A0;'
    end
  end

  def current_percentage_value
    range = max_value - min_value
    return 0 if range == 0
    percentage = (last_value - min_value) / range
    return (percentage * 100).to_i
  end

end
