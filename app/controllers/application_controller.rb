class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger

  before_action :authorize!

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= PermissionService.new(
      user: current_user,
      controller: params[:controller],
      action: params[:action]
    )
  end

  def authorize!
    render_404 unless current_permission.authorized?
  end

  def confirm!
    redirect_to confirmation_path if current_user.status == 'inactive'
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
