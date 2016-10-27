class Api::V1::TripsController < ApiController
  def index
    render json: @user.trips
  end
end
