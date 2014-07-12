class CamerasController < ApplicationController
  
  before_filter :authenticate_user!
  

  def index
    @cameras = current_user.cameras.order('name ASC')
  end

end
