class NumericSensor < Sensor

  #############
  # Constants #
  #############

  TREND_ARROW_UP = '&#x25B2;'
  TREND_ARROW_DOWN = '&#x25BC;'
  TREND_ARROW_STABLE = '&#x25A0;'

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

  # Determines the current trend in data values.  Currently looks at the difference
  # between the current and 2 values-ago.
  #
  # Returns:
  # -1 for going down
  #  0 for stable
  # +1 for going up
  def trend_direction
    return 0 if self.data_points.count <= 2
    prior_value = self.data_points.order('created_at DESC').limit(3)[2].value
    if last_value < prior_value
      return -1
    elsif last_value > prior_value
      return 1
    else
      return 0
    end
  end

  def trend_direction_arrow
    trend = trend_direction
    if trend > 0
      return TREND_ARROW_UP
    elsif trend < 0
      return TREND_ARROW_DOWN
    elsif trend == 0
      return TREND_ARROW_STABLE
    end
  end

  def current_percentage_value
    range = max_value - min_value
    return 0 if range == 0
    percentage = (last_value - min_value) / range
    return (percentage * 100).to_i
  end

end
