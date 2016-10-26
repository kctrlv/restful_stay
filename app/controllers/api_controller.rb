class ApiController < ActionController::API
  before_action :authenticate
  before_action :set_user

  private

  def authenticate
    return not_found_error("You must provide an API key") unless params[:api_key]
    return not_found_error("The API key is invalid") unless valid_key(params[:api_key])
  end

  def set_user
    @user = User.find_by(api_key: params[:api_key])
  end

  def not_found_error(msg)
    render json: { error: msg }, status: :not_found
  end

  def valid_key(key)
    User.find_by(api_key: key)
  end
end
