class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  add_flash_types :success, :info, :warning, :danger

  before_action :authorize!

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= PermissionService.new(user: current_user,
                                                  controller: params[:controller],
                                                  action: params[:action])
  end

  def authorize!
    unless current_permission.authorized?
      render_404
    end
  end

  def confirm!
    if current_user.status == 'inactive'
      redirect_to confirmation_path
    end
  end

  def render_404
    render :file => "#{Rails.root}/public/404.html",  :status => 404
  end

  def path_based_on_role
    if current_user.admin?
      redirect_to admin_dashboard_path
    else
      redirect_to root_path
    end
  end

  def path_based_on_status
    if current_user.inactive?
      redirect_to confirmation_path
    elsif current_user.suspended?
      session.clear
      flash[:danger] = "Your account is temporarily suspended"
      redirect_to login_path
    end
  end
end
