class UsersController < ApplicationController
  before_filter :authenticate_user!

  def installation
    @api_key = current_user.api_key
  end

end