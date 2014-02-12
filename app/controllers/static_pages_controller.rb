class StaticPagesController < ActionController::Base
  layout 'application'
  before_filter :authenticate_user!, only: [ :application ]

  def home
    return redirect_to sensors_path if current_user
  end

end