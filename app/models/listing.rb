class Listing < ApplicationRecord
  belongs_to :city
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :price_per_night

  has_many :listing_days
  has_many :days, through: :listing_days
end
