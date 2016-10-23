class Trip < ApplicationRecord
  validates_presence_of(:checkin)
  validates_presence_of(:checkout)

  belongs_to :listing
  belongs_to :guest, class_name: "User"
end
