class StaticPagesController < ApplicationController
  def landing_page
    return redirect_to '/dashboard' if current_user
    return redirect_to new_user_session_path
  end
end
