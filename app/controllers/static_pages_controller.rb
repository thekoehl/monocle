class StaticPagesController < ApplicationController
  def landing_page
    return redirect_to '/dashboard' if current_user
  end
end
