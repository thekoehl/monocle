class SensorsController < ApplicationController
    before_filter :authenticate_user!
    def big_display
        @sensor = current_user.sensors.find_by_id params[:id]
        raise "Could not locate sensor by id #{params[:id]}" unless @sensor
    end
    def dashboard
        @sensors = current_user.sensors.all
    end
    def data_points
    	@sensor = current_user.sensors.find_by_id params[:id]
    	raise "Could not locate sensor by id #{params[:id]}" unless @sensor

    	render :json => @sensor.average_by_hour.to_a
    end
    def index
        @sensors = current_user.sensors.all
    end
    def show
    	@sensor = current_user.sensors.find_by_id params[:id]
        @latest_data_points = @sensor.data_points.all(:conditions => ["created_at > ?", Time.now-48.hours], :order => "created_at DESC")
    	raise "Could not locate sensor by id #{params[:id]}" unless @sensor
    end
end
