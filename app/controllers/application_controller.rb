class ApplicationController < ActionController::Base
  layout "fixed"
  protect_from_forgery

  before_filter :create_api_key_if_necessary
  before_filter :start_page_load_timer

  def create_api_key_if_necessary
    if current_user && (current_user.api_key == nil || current_user.api_key.empty?)
      current_user.api_key = SecureRandom.uuid
      current_user.save!
    end
  end
  def after_sign_in_path_for(resource)
    sensors_path
  end
  def start_page_load_timer
    @load_started_at = Time.now
  end
end
