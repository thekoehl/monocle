class DashboardController < ApplicationController
  before_filter :authenticate_user!
  def index
    @groups = current_user.groups.includes(:sensors)
  end
end
