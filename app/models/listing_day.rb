class ListingDay < ApplicationRecord
  scope :available, -> { where(status: 'available') }
  validates_presence_of :status

  belongs_to :listing
  belongs_to :day
end
