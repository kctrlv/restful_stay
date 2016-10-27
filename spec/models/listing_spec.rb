require 'rails_helper'

RSpec.describe Listing, type: :model do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price_per_night) }
  end

  context "associations" do
    it { should belong_to(:city) }
    it { should belong_to(:host) }
    it { should have_many(:listing_days) }
    it { should have_many(:days) }
  end
end
