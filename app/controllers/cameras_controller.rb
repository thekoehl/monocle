class CamerasController < ActionController::Base
  layout 'application'

  ##################
  # Action Filters #
  ##################

  before_filter :authenticate_user!

  ####################
  # Instance Methods #
  ####################

  def index
    @cameras = current_user.cameras.order("cameras.name ASC")
  end

end
