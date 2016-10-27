class Trip < ApplicationRecord
  after_save :update_listing_days, on: :create

  validates_presence_of(:checkin)
  validates_presence_of(:checkout)

  belongs_to :listing
  has_one :host, class_name: "User", through: :listing
  belongs_to :guest, class_name: "User"

  has_one :review

  def duration
    (checkout - checkin).to_i
  end

  def dates
    (checkin..checkout).to_a[0..-2]
  end

  def dates_available_to_book
    available_dates = listing.available_days.pluck(:date)
    (dates - available_dates).empty?
  end

  private

  def update_listing_days
    booked_ids = dates.map { |date| Day.find_by(date: date).id }
    listing.listing_days.where(day: booked_ids).update_all(status: "booked")
  end
end
