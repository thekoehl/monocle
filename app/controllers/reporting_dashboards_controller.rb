class ReportingDashboardsController < ApplicationController
	before_filter :authenticate_user!
	def create
		@reporting_dashboard = ReportingDashboard.new
		assign_attributes_to_dashboard

		unless @reporting_dashboard.valid?
			@sensors = current_user.sensors			
			return render :new
		end
		
		@reporting_dashboard.save!
		flash[:notice] = "Reporting Dashboard saved."
		return redirect_to reporting_dashboards_path		
	end
	def edit
		@reporting_dashboard = current_user.reporting_dashboards.find_by_id params[:id]
		raise "That's an invalid reporting dashboard." if @reporting_dashboard.nil?

		@sensors = current_user.sensors
	end
	def index
		@reporting_dashboards = current_user.reporting_dashboards
	end
	def new
		@reporting_dashboard = ReportingDashboard.new
		@sensors = current_user.sensors
	end
	def update
		@reporting_dashboard = current_user.reporting_dashboards.find_by_id params[:id]
		raise "That's an invalid reporting dashboard." if @reporting_dashboard.nil?
		
		assign_attributes_to_dashboard		
		
		unless @reporting_dashboard.valid?
			@sensors = current_user.sensors			
			return render :edit
		end		
		@reporting_dashboard.save!
		flash[:notice] = "Reporting Dashboard saved."
		return redirect_to reporting_dashboards_path		
	end
private
	def assign_attributes_to_dashboard
		raise "You must create a class level @reporting_dashboard first." if @reporting_dashboard.nil?
		@reporting_dashboard.title = params[:reporting_dashboard][:title]
		@reporting_dashboard.user = current_user

		@reporting_dashboard.sensors.clear
		return if params[:reporting_dashboard][:sensor_ids].nil?
		
		params[:reporting_dashboard][:sensor_ids].each do |sensor_id|
			sensor = current_user.sensors.find_by_id sensor_id
			raise "Could not locate sensor by id #{sensor_id}" if sensor.nil?
			@reporting_dashboard.sensors << sensor
		end
	end
end
