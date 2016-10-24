class TripsController < ApplicationController
  def index
    @trips = current_user.trips
  end

  def new
    @trip = Trip.new(listing: Listing.find(params[:listing]))
  end

  def create
    redirect_if_invalid_dates
    @trip = Trip.new(listing: Listing.find(trip_params[:listing_id]),
                     guest: current_user,
                     checkin: Day.find(trip_params[:checkin]).date,
                     checkout: Day.find(trip_params[:checkout]).date)
    if @trip.save
      flash[:success] = "Your trip has been booked for #{@trip.listing.name}"
      redirect_to trips_path
    else
      ### IF A DAY IN BETWEEN START AND END NOT AVAILABLE
      ### COMPARE THE ARRAY OF REQUESTED VS THE ARRAY AVAILABLE, CHECK ALL IN A ARE IN B
      ### CONTINUE TO FLESH OUT THE TEST

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
