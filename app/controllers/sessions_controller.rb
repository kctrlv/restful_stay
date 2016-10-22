class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email_address: params[:session][:email_address])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if user.inactive?
        redirect_to confirmation_path
      else
        redirect_to root_path
      end
    else
      flash.now[:danger] = "Email and/or Password is invalid, please try again."
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
