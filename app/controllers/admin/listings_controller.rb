class Admin::ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:listing_id])
  end

  def destroy
   @listing  = Listing.find(params[:listing_id])
   @listing.clear_listing_days
   @listing.destroy
    flash[:success] = "Listing deleted successfully"
    redirect_to admin_manage_listings_path
  end
end
