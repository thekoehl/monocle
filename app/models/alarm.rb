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
		return if self.active
		if self.trigger_type == "low_level"
			self.active = data_point_value <= self.trigger_value
		elsif self.trigger_type == "high_level"
			self.active = data_point_value >= self.trigger_value
		end
		if self.active
			self.last_triggered = Time.now 
			self.last_triggered_value = data_point_value
		end
		self.save
	end
	def units
		return self.sensor.data_points.last.units
	end
end
