class DashboardController < ApplicationController
  before_action :confirm!

  def index
    if current_user
      @user = current_user
      # @trips = @user.trips
    else
      render_404
    end
  end
end
