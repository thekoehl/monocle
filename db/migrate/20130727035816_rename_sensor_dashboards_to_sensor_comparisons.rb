class RenameSensorDashboardsToSensorComparisons < ActiveRecord::Migration
	def change
		rename_table :reporting_dashboards, :comparisons
		rename_table :reporting_dashboards_sensors, :comparisons_sensors
		rename_column :comparisons_sensors,
		              :reporting_dashboard_id,
		              :comparison_id
	end
end
