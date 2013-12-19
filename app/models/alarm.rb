class Alarm < ActiveRecord::Base

	ALARM_TYPES = {
		low_level: 'low_level',
		high_level: 'high_level'
	}

	FLAPPING_LIMIT = 6.hours # Only allow notifications every 6 hours

  #################
	# Relationships #
	#################

	belongs_to :sensor
	belongs_to :user

  delegate :name, :to => :sensor, :prefix => true

	###############
	# Validations #
	###############

	validates :alarm_type, presence: true
	validates :sensor, presence: true
	validates :trigger_value, presence: true
	validates :user, presence: true

  ##################
	# Action Filters #
	##################

	before_validation :associate_user
	def associate_user
		return true unless self.sensor && self.sensor.user
		self.user = self.sensor.user

		return true
	end

  ####################
	# Instance Methods #
	####################

	def check_for_and_trigger_if_needed
		last_datapoint = self.sensor.data_points.order("created_at ASC").last

		if self.is_low_level? && last_datapoint.value <= self.trigger_value
			self.trigger!
		elsif self.is_high_level? && last_datapoint.value >= self.trigger_value
			self.trigger!
		end
	end

	def send_notification_if_needed
		return if !last_notification_sent_at.nil? && (Time.now - last_notification_sent_at <= FLAPPING_LIMIT)
		self.last_notification_sent_at = Time.now
		MonocleMailer.alarm_triggered_notification(self).deliver!
	end

	def trigger!
		self.last_triggered_at = Time.now
		self.send_notification_if_needed
		self.save!
	end

  ##############
	# Predicates #
	##############

	def is_low_level?
		return self.alarm_type == ALARM_TYPES[:low_level]
	end

	def is_high_level?
		return self.alarm_type == ALARM_TYPES[:high_level]
	end

end
