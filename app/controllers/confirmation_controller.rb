class ConfirmationController < ApplicationController
  def new
    if current_user
      @user = current_user
    else
      render_404
    end
  end

  def create
    @user = User.find(params['id'])
    if @user.verification_code == params['code']
      @user.activate
      redirect_to dashboard_path
    else
      flash.now[:danger] = "Code do not match, please try again."
      render :new
    end
  end
end
