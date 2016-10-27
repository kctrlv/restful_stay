class Api::V1::ReviewsController < ApiController
  before_action :authorize, only: [:create, :destroy, :update]
  before_action :set_web

  def create
    @review = Review.new(review_params)
    if @review.save
      return redirect_to trips_path if @web
      render json: { body: "Your review has been posted" }
    else
      return redirect_to new_trip_review_path if @web
      render json: { error: "Missing parameters" }, status: :not_found
    end
  end

  def show
    @review = Review.find_by(trip_id: params[:trip_id])
    return redirect_to trip_review_path(params[:trip_id]) if @web
    if @review
      render json: Review.find_by(trip_id: params[:trip_id])
    else
      render json: { error: "No Review for this Trip"}, status: :not_found
    end
  end

  def destroy
    @review = Review.find_by(trip_id: params[:trip_id])
    if @review
      @review.destroy
      return redirect_to trips_path if @web
      render json: { body: "Your review has been removed" }
    else
      return redirect_to trips_path if @web
      render json: { error: "No Review for this Trip"}, status: :not_found
    end
  end

  def update
    @review = Review.find_by(trip_id: params[:trip_id])
    if @review.update_attributes(review_params)
      return redirect_to trip_review_path(params[:trip_id]) if @web
      render json: { body: "Your review has been updated" }
    else
      return redirect_to edit_trip_review_path if @web
      render json: { error: "Missing parameters" }, status: :not_found
    end
  end

  private

  def review_params
    if @web_params
      params.require(:review).permit(:subject, :body).merge(trip_id: params[:trip_id])
    else
      params.permit(:subject, :body, :trip_id)
    end
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

  def set_web
    if @web_params
      @web = @web_params.delete('web')
    end
  end
end
