class Api::V1::AvailabledatesController < ApplicationController
  respond_to :json
  skip_before_action :authorize!

  def index
    respond_with Listing.find(params[:id]).available_days

  end
end
