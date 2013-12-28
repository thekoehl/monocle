class SensorsController < ActionController::Base
  layout 'application'

  before_filter :authenticate_user!

  def index; end

end
