class CameraEventsController < ActionController::Base
 
  layout 'application'

  ##################
  # Action Filters #
  ##################

  before_filter :authenticate_user!

  ####################
  # Instance Methods #
  ####################

  def index
    @camera_events = current_user.camera_events.order("camera_events.created_at DESC")
  end

  def destroy_all
    current_user.camera_events.destroy_all
    return redirect_to camera_events_path
  end

end
