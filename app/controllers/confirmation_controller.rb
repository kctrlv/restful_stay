class ConfirmationController < ApplicationController
  def new
    @user = current_user
  end

  def create
    @user = User.find(params['id'])
    if @user.verification_code == params['code']
      @user.update_attributes(status: "active")
      redirect_to dashboard_path
    else
      flash.now[:danger] = "Code do not match, please try again."
      render :new
    end
  end
end
