class CreateReportingDashboards < ActiveRecord::Migration
  def change
    create_table :reporting_dashboards do |t|
    	t.string :title
      t.timestamps
    end
    create_table :reporting_dashboards_sensors do |t|
    	t.references :reporting_dashboard
    	t.references :sensor
    end
  end
end
