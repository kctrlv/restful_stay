class ListingDay < ApplicationRecord
  validates_presence_of :status

  belongs_to :listing
  belongs_to :day
end
