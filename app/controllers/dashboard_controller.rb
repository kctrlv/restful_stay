class DashboardController < ApplicationController
  before_action :confirm!

  def index
    @user = current_user if current_user
    @trips = current_user.trips
  end

  def edit
    @user = current_user if current_user
  end
end
