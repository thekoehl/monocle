class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
    @current_user ||= super && User.includes(:groups => {:sensors => :last_data_point}).find(@current_user.id)
  end
end
