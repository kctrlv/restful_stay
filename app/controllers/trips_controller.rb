class TripsController < ApplicationController
  def index
    @trips = current_user.trips
  end

  def new
    @trip = Trip.new(listing: Listing.find(params[:listing]))
  end

  def create
    return wrong_dates if trip_params[:checkin] > trip_params[:checkout]
    @trip = Trip.new(listing: Listing.find(trip_params[:listing_id]),
                     guest: current_user,
                     checkin: Day.find(trip_params[:checkin]).date,
                     checkout: Day.find(trip_params[:checkout]).date)
    return dates_already_booked unless @trip.dates_available_to_book
    if @trip.save
      flash[:success] = "Your trip has been booked for #{@trip.listing.name}"
      redirect_to trips_path
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:checkin, :checkout, :listing_id)
  end

  def wrong_dates
    redirect_to new_trip_path(listing: trip_params[:listing_id]), flash: {warning: "Please make sure your checkout date comes after the checkin date"}
  end

  def dates_already_booked
    redirect_to new_trip_path(listing: trip_params[:listing_id]), flash: {warning: "Dates within your selection have already been booked"}
  end
end
