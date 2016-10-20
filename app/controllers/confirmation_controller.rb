class ConfirmationController < ApplicationController
  def new
    if current_user
      @user = current_user
    else
      render_404
    end
  end

  def create

  end


end
