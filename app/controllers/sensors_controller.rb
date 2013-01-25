class SensorsController < ApplicationController
    before_filter :authenticate_user!

    def big_display
        @sensor = current_user.sensors.find_by_id params[:id]
        raise "Could not locate sensor by id #{params[:id]}" unless @sensor
    end
    def dashboard
        @sensors = current_user.sensors.all
    end
    def data
        @sensor = current_user.sensors.find_by_id params[:id]
        @latest_data_points = @sensor.data_points.all(:conditions => ["created_at > ?", Time.now-48.hours], :order => "created_at DESC")
    end
    def data_points
    	@sensor = current_user.sensors.find_by_id params[:id]
    	raise "Could not locate sensor by id #{params[:id]}" unless @sensor
        if params[:chart_range] == "this-day"
    	   render :json => @sensor.average_by_hour.to_a
        elsif params[:chart_range] == "this-month"
            render :json => @sensor.average_by_day.to_a
        elsif params[:chart_range] == "all-time"
            render :json => @sensor.average_by_month.to_a
        end
    end
    def destroy
        @sensor = current_user.sensors.find_by_id params[:id]
        @sensor.delete
        flash[:notice] = "Sensor has been deleted."
        return redirect_to sensors_path
    end
    def index
        @sensors = current_user.sensors.all
        @active_alarms = current_user.sensors.collect {|sensor| sensor.alarms.where(:active => true)}.flatten.compact
        @signal_faulted_sensors = current_user.sensors.signal_faulted
    end
    def show
    	@sensor = current_user.sensors.find_by_id params[:id]
    	raise "Could not locate sensor by id #{params[:id]}" unless @sensor
        @data_points = @sensor.data_points.where("created_at >= ?", Time.now - 1.day).ordered_by_latest
    end
end
