class Api::V1::AvailabledatesController < ApplicationController
  respond_to :json
  skip_before_action :authorize!

  def index
    @dates = Listing.find(params[:id]).available_days.map do |date_object|
      date_object.date.strftime('%Y-%m-%-d')
    end
    respond_with @dates
  end
end
