class Listing < ApplicationRecord
  belongs_to :city
  belongs_to :host, class_name: "User"

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :price_per_night

  has_many :listing_days
  has_many :days, through: :listing_days
  # scope :available_days, -> { listing_days.where(status: 'available') }

  def self.make(params, user_id)
    date_range = params.delete(:start_date)..params.delete(:end_date)
    days = date_range.to_a.map{ |day_id| Day.find(day_id) }
    listing = Listing.new(params.merge(host_id: user_id))
    listing.days << days
    return listing
  end

  def available_listing_days
    listing_days.where(status: 'available')
  end

  def clear_listing_days
    listing_days.clear
  end

  def available_days
    all_days = available_listing_days.map { |day| Day.find(day.day_id) }
    all_days.sort.reject{ |day| day.date < Date.today }
  end

  def self.revise(params, listing_id)
    listing = Listing.find(listing_id)
    listing.days.clear
    date_range = params.delete(:start_date)..params.delete(:end_date)
    days = date_range.to_a.map{ |day_id| Day.find(day_id) }
    listing.days << days
    return listing
  end

  def start_date
  end

  def end_date
  end
end
