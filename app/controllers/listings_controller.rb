class ListingsController < ApplicationController
  def index
  end

  def new
    @listing = Listing.new
  end
end
