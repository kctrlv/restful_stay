class TripsController < ApplicationController
  def new
    @trip = Trip.new(listing: Listing.find(params[:listing]))
  end

  def create
    redirect_if_invalid_dates
    byebug
    @trip = Trip.new(listing: Listing.find(trip_params[:listing_id]),
                     guest: current_user,
                     checkin: Day.find(trip_params[:checkin]),
                     checkout: Day.find(trip_params[:checkout]))
    if @trip.save
      flash[:success] = "Your trip has been booked"
      # redirect_to trips_path
    else


    end
  end

  private

  def trip_params
    params.require(:trip).permit(:checkin, :checkout, :listing_id)
  end

  def redirect_if_invalid_dates
    if trip_params[:checkin] > trip_params[:checkout]
      flash[:danger] = "Please make sure your checkout date comes after the checkin date"
      redirect_to new_trip_path(listing: trip_params[:listing_id])
    end
  end

end
