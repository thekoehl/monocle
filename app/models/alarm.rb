class Alarm < ActiveRecord::Base
	attr_accessible :trigger_type
	
	belongs_to :sensor
end
