require 'rails_helper'

RSpec.describe ListingDay, type: :model do
  context "validations" do
    it { should validate_presence_of(:status) }
  end

  context "associations" do
    it { should belong_to(:listing) }
    it { should belong_to(:day) }
  end
end
