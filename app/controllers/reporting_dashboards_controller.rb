class ReportingDashboardsController < ApplicationController
	before_filter :authenticate_user!
	def index
		@reporting_dashboards = current_user.reporting_dashboards
	end
	def new
		@reporting_dashboard = ReportingDashboard.new
		@sensors = current_user.sensors
	end
end
