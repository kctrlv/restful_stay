class Trip < ApplicationRecord
  validates_presence_of(:checkin)
  validates_presence_of(:checkout)

  belongs_to :listing
  belongs_to :guest, class_name: "User"

  def duration
    (checkout - checkin).to_i
  end

  def dates
    (checkin..checkout).to_a[0..-2]
  end
end
