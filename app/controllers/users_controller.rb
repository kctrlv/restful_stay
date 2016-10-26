class UsersController < ApplicationController
  protect_from_forgery

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      @user.roles << Role.find_by(name: "traveler")
      ConfirmationSender.send_confirmation_to(@user)
      redirect_to confirmation_path
    else
      redirect_to signup_path
    end
  end

  def update 
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_show_path(current_user)
    else
      redirect_to dashboard_edit_path
    end
  end

  def show
    @user = User.find(params[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:id,
                                 :first_name,
                                 :last_name,
                                 :email_address,
                                 :password,
                                 :phone_number,
                                 :description,
                                 :picture_url)
  end
end
