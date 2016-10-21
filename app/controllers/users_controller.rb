class UsersController < ApplicationController
  protect_from_forgery

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      ConfirmationSender.send_confirmation_to(@user)
      redirect_to confirmation_path #removed (current_user)
    else
      render :new
    end
  end
  
  def update 
    if current_user.update(user_params)
      redirect_to profile_show_path(current_user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email_address,
                                 :password,
                                 :phone_number,
                                 :description,
                                 :picture_url)
  end
end
