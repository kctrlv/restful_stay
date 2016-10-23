class ListingsController < ApplicationController
  def index
    @listings = current_user.listings
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.make(listing_params, current_user.id)
    if @listing.save
      flash[:success] = "Your listing was created"
      redirect_to @listing
    else
      flash.now[:danger] = "Your listing was not created because of bad parameters"
      render :new
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end
  
  def edit
    @listing = Listing.find(params[:id])
  end
  
  def update
    @listing = Listing.find(params[:id])
    @listing = Listing.revise(listing_params, @listing.id)
    if @listing.update(updated_params)
      flash[:success] = "Listing Updated Successfully"
      redirect_to @listing
    else
      flash.now[:danger] = "Listing not updated, due to incorrect parameters"
      render :edit
    end
  end
  
  def destroy 
    @listing  = Listing.find(params[:id])
    @listing.destroy
    flash[:success] = "Listing deleted successfully"
    redirect_to listings_path
  end
  
  private

  def listing_params
    params.require(:listing).permit(:name, :image_url, :city_id, :description, :price_per_night, :start_date, :end_date)
  end
  
  def updated_params
    params.require(:listing).permit(:name, :image_url, :city_id, :description, :price_per_night)
  end
end
