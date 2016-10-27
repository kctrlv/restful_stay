class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @user   = current_user
  end

  def show
    @review = Trip.find(params[:trip_id]).review
  end

  def edit
    @review = Trip.find(params[:trip_id]).review
    @user   = current_user
  end

  private

  def review_params
    params.require(:review).permit(:subject, :body)
  end
end
