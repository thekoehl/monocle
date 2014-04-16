class Api::BaseController < ApplicationController

  before_filter :load_and_authenticate_api_user!
  skip_before_filter :verify_authenticity_token

  def load_and_authenticate_api_user!
    return render(json: json_failure('No api_key specified'), status: 403) unless params[:api_key]
    @current_user = User.where(api_key: params[:api_key]).first
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