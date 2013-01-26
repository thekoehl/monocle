# == Schema Information
#
# Table name: alarms
#
#  id             :integer          not null, primary key
#  sensor_id      :integer
#  active         :boolean
#  trigger_value  :integer
#  trigger_type   :string(255)
#  last_triggered :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Alarm < ActiveRecord::Base
	TRIGGER_TYPES = %w(high_level low_level)

	attr_accessible :trigger_type
	attr_accessible :trigger_value
	attr_accessible :sensor_id

	validates :sensor_id,     :presence => true
	validates :trigger_value, :presence => true
	validates :trigger_type,  :presence => true
	
	belongs_to :sensor

	scope :active, where(:active => true)

	def check_for_and_trigger data_point_value
		new_active = check_if_active data_point_value
		
		if new_active
			self.last_triggered = Time.now 
			self.last_triggered_value = data_point_value
		end

		if new_active != self.active
			self.active = new_active
			self.save
		end

		send_notification data_point_value if self.active
	end

	def units
		return self.sensor.data_points.last.units
	end

	private
	# Checks if, based on the trigger type, the alarm is active
	# or not.
	#
	# Raises an exception if an unexpected trigger_type is encountered.
	def check_if_active data_point_value
		active = false
		if self.trigger_type == "low_level"
			return data_point_value <= self.trigger_value
		elsif self.trigger_type == "high_level"
			return data_point_value >= self.trigger_value
		end

		raise "Unexpected trigger type of #{self.trigger_type} for this alarm!"
	end

	# Triggers a notification email if the alarm is triggered and has not been sent in the
	# last 6 hours.
	def send_notification data_point_value
		user = self.sensor.user
		return if !user.last_notification_sent_at.nil? && user.last_notification_sent_at <= Time.now - 6.hours

		warning_message = "#{self.sensor.name} is experiencing a #{self.trigger_type} value @ #{data_point_value}#{self.units}!"
		
		UserMailer.send_alarm_notification user, self, data_point_value

		user.last_notification_sent_at = Time.now
		user.save!
	end
end
