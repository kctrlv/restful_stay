class City < ApplicationRecord
  validates_presence_of :name
  has_many :listings

  def slug
    name.downcase.tr(" ", "-")
  end

  def to_param
    slug
  end
end
