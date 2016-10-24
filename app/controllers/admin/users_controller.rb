class Admin::UsersController < ApplicationController
  def index
    @admin = current_user
  end
end