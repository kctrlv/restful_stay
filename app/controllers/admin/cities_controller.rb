class Admin::CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def show
    @city = City.find(params[:city_id])
  end

  def destroy
    @city  = City.find(params[:city_id])
    @city.destroy
    flash[:success] = "City deleted successfully"
    redirect_to admin_manage_cities_path
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)
    if @city.save
      redirect_to admin_manage_cities_path
    else
      render :new
    end
  end

  private

  def city_params
    params.require(:city).permit(:name)
  end
end
