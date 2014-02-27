class DashboardsController < ActionController::Base

  before_filter :authenticate_user!
  before_filter :load_dashboard_data

  def scifi; end

private

  # Loads the dashboard data.  All dashboards should use the same data.
  def load_dashboard_data
    @cameras = current_user.cameras
    @sensors = current_user.sensors.order('name ASC')

    return true
  end

end
