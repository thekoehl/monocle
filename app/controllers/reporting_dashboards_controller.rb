class ReportingDashboardsController < ApplicationController
	def index
		@reporting_dashboards = ReportingDashboard.all
	end
end
