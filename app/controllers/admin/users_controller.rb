class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    if status_change_params(@user)
      redirect_to admin_manage_users_path
    else
      flash.now[:danger] = "Please make sure you have all the info needed."
      redirect_to admin_edit_user_path
    end
  end

  private
  def status_change_params(user)
    user.update_attribute(:status, params[:user][:status])
  end
end
