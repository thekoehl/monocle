class AddUserIdToReportingDashboards < ActiveRecord::Migration
  def change
    change_table :reporting_dashboards do |t|
      t.references :user
    end
  end
end
