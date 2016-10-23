require 'rails_helper'

RSpec.describe Trip, type: :model do
  context "validations" do
    it { should validate_presence_of(:checkin)}
    it { should validate_presence_of(:checkout)}
  end

  context "associations" do
    it { should belong_to(:listing) }
    it { should belong_to(:guest) }
  end
end
