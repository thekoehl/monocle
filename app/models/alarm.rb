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
end
