class PagesController < ApplicationController
    def home
      return redirect_to new_user_session_path
    end
end
