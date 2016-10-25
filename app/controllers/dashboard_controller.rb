class DashboardController < ApplicationController
  before_action :confirm!

  def index
    if current_user
      @user = current_user
    end
    @trips = current_user.trips
  end

  def edit
    if current_user
      @user = current_user
    end
  end
end
