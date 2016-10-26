class Api::V1::ReviewsController < ApiController
  before_action :authorize, only: [:create]

  def create
    @review = Review.new(review_params)
    if @review.save
      render json: { body: "Your review has been posted" }
    else
      render json: { error: "Missing parameters" }, status: :not_found
    end
  end

  private

  def review_params
    params.permit(:subject, :body, :trip_id)
  end

  def authorize
    unless trip_exists && trip_belongs_to_user
      return not_found_error("Unauthorized: You cannot review a trip that you have not booked")
    end
  end

  def trip_exists
    Trip.where(id: params[:trip_id]).first
  end

  def trip_belongs_to_user
    trip_exists.in?(@user.trips)
  end
end
