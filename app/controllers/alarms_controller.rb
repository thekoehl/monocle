class AlarmsController < ApplicationController
	before_filter :authenticate_user!
	def create
		@alarm = Alarm.new params[:alarm]
		unless @alarm.valid?
			@sensors = current_user.sensors
			@trigger_types = Alarm::TRIGGER_TYPES
			return render :new
		end
		raise "That's not your sensor!" if current_user.sensors.where(:id => @alarm.sensor_id).first.nil?
		raise @alarm.inspect
	end
	def new
		@alarm = Alarm.new
		@sensors = current_user.sensors
		@trigger_types = Alarm::TRIGGER_TYPES
	end
end
