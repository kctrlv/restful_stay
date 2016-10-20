class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to confirmation_path
    else
      render :new
    end
  end

  # def confirm
  #   @user = current_user
  # end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email_address, :password, :phone_number)
  end
end
