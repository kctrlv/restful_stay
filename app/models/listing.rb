class Listing < ApplicationRecord
  belongs_to :city
  belongs_to :host, class_name: "User"

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :price_per_night

  has_many :listing_days
  has_many :days, through: :listing_days

  def self.make(params, user_id)
    date_range = params.delete(:start_date)..params.delete(:end_date)
    days = date_range.to_a.map{ |day_id| Day.find(day_id) }
    listing = Listing.new(params.merge(host_id: user_id))

    byebug
  end

  def start_date
  end

  def end_date
  end
end
