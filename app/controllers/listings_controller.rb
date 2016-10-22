class ListingsController < ApplicationController
  def index
  end

  def new
    @listing = Listing.new
  end

  def create
    # byebug
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

  private

  def listing_params
    params.require(:listing).permit(:name, :image_url, :city_id, :description, :price_per_night, :start_date, :end_date)
  end
end
