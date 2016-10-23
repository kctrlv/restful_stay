class Day < ApplicationRecord
  validates_presence_of :date
  scope :future_days, -> { where("date >= :date", date: Date.today).order(:date) }

  has_many :listing_days
  has_many :listings, through: :listing_days

end
