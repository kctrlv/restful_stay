class ReservationsController < ApplicationController
  def index
    @trips = Trip.joins(:host).select{ |t| t.host == current_user }
  end

  
end
