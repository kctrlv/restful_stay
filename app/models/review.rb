class Review < ApplicationRecord
  belongs_to :trip

  validates_presence_of :subject
  validates_presence_of :body
end
