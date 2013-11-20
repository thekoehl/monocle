class Api::BaseController < ApplicationController
  def load_and_authenticate_api_user!
    return render(json: json_failure('No api_key specified'), status: 403) unless params[:api_key]
    @current_user = User.find_by_api_key params[:api_key]
    return render(json: json_failure('No such user with that api key'), status: 403) unless @current_user
  end

  def json_failure(value)
    messages = value.is_a?(Array) ? value : [value]
    { "result" => false, :messages => messages }
  end

  def json_success
    { "status" => "success" }
  end

  rescue_from Exception do |exception|
    render json: json_failure(exception.message), status: 500
  end
end