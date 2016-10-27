class ApiController < ActionController::API
  before_action :remake_params
  before_action :authenticate
  before_action :set_user

  private

  def authenticate
    params[:api_key] ||= @web_params[:api_key] if @web_params
    return not_found_error("You must provide an API key") unless params[:api_key]
    return not_found_error("The API key is invalid") unless valid_key(params[:api_key])
  end

  def set_user
    params[:api_key] ||= @web_params[:api_key] if @web_params
    @user = User.find_by(api_key: params[:api_key])
  end

  def not_found_error(msg)
    render json: { error: msg }, status: :not_found
  end

  def valid_key(key)
    User.find_by(api_key: key)
  end

  def remake_params
    unless params[:utf8].nil?
      if params['review']
        @web_params = params.require("review").merge(web: true)
                            .merge(trip_id: params[:trip_id])
      else
        @web_params = params.merge(web: true)
      end
    end
  end
end
