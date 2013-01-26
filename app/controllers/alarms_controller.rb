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
		@alarm.save!
		flash[:notice] = "Alarm saved."
		return redirect_to alarms_path		
	end
    
    def destroy
        @alarm = Alarm.find_by_id params[:id]
        raise "That's not your sensor!" if current_user.sensors.where(:id => @alarm.sensor_id).first.nil?
        @alarm.delete
        flash[:notice] = "Alarm has been deleted."
        return redirect_to alarms_path
    end
	
	def index
		@alarms = current_user.sensors.map { |sensor| sensor.alarms }.flatten.compact		
	end
	
	def edit
		flash[:notice] = "Updating this alarm will clear its active state!"
		@alarm = Alarm.find_by_id params[:id]
		@sensors = current_user.sensors
		@trigger_types = Alarm::TRIGGER_TYPES
		raise "That's not your alarm!" if current_user.sensors.where(:id => @alarm.sensor_id).first.nil?
	end
	
	def new
		@alarm = Alarm.new
		@sensors = current_user.sensors
		@trigger_types = Alarm::TRIGGER_TYPES
	end

	# Used as a JSON call to reset the triggered value on a specific alarm.
	# Expects: An alarm id
	def reset
		begin
			@alarm = Alarm.find_by_id params[:id]
			raise "That's not your sensor!" if current_user.sensors.where(:id => @alarm.sensor_id).first.nil?

			@alarm.active = false
			@alarm.last_triggered = nil
			@alarm.save!
			render :json => {success: true, alarm: @alarm}
		rescue Exception => ex
			render :json => {success: false, message: ex.message}
		end
	end

	def update
		@alarm = Alarm.find_by_id params[:id]
		@alarm.update_attributes(params[:alarm])
		@alarm.active = false
		unless @alarm.valid?
			@sensors = current_user.sensors
			@trigger_types = Alarm::TRIGGER_TYPES
			return render :edit
		end
		raise "That's not your sensor!" if current_user.sensors.where(:id => @alarm.sensor_id).first.nil?
		@alarm.save!
		flash[:notice] = "Alarm saved."
		return redirect_to alarms_path		
	end
end
