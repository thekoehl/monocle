class Api::AlarmsController < Api::BaseController
	before_filter :load_and_authenticate_api_user!
	protect_from_forgery :except => :create # This is meant to be called from the outside
end
