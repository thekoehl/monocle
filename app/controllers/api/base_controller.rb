class Api::BaseController < ApplicationController
	def load_and_authenticate_api_user!
		return render json: json_failure('No api_key specified') unless params[:api_key]
		@current_user = User.find_by_api_key params[:api_key]
		return render json: json_failure('No such user with that api key') unless @current_user
	end

	def json_failure(value)
    messages = value.is_a?(Array) ? value : [value]
    { "result" => false, :messages => messages }
  end

  def json_success
    { "result" => true }
  end
end