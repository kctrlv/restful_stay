class CitiesController < ApplicationController
  def show
    @city = City.find_by(name: params[:city_name].gsub("-"," ").titleize)
    # byebug
  end
end
