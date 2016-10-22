class Day < ApplicationRecord
  validates_presence_of :date

  has_many :listing_days
  has_many :listings, through: :listing_days
end
