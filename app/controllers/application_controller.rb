class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :load_groups

  def load_groups
    return unless current_user
    @groups = current_user.groups
  end
end
