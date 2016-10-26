class ReservationsController < ApplicationController
  def index
    @listings = Listing.where(host_id: current_user)

  end
end
