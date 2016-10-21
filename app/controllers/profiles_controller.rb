class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end
  
  def edit
    if current_user
      @user = current_user
    else
      render_404
    end
  end
end