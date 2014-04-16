class StaticPagesController < ApplicationController
  def landing_page
    return redirect_to dashboards_path if current_user
  end
end
