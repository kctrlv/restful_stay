require 'rails_helper'

RSpec.describe Day, type: :model do
  context "validations" do
    it { should validate_presence_of(:date) }
  end

  context "associations" do
    it { should have_many(:listing_days) }
    it { should have_many(:listings) }
  end
end
