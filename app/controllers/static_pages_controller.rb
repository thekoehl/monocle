class StaticPagesController < ActionController::Base
  layout 'application'
  before_filter :authenticate_user!, only: [ :application ]

  def home
    return render "application" if current_user
  end

end