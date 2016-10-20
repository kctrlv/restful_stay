class UserrolesController < ApplicationController
  def create
    if params['become'] == 'host'
      current_user.roles << Role.find_by(name: 'host')
      redirect_to root_path
    end
  end
end
