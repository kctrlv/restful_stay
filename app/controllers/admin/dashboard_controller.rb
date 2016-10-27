class Admin::DashboardController < ApplicationController
  def index
    @admin = current_user
  end
end