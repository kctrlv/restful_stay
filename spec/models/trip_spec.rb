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

  it 'should know its duration' do
    t = Trip.new(
    checkin: Date.parse('01-11-2016'),
    checkout: Date.parse('05-11-2016'))
    expect(t.duration).to eq(4)
  end

  it 'should know its dates' do
    t = Trip.new(
    checkin: Date.parse('01-11-2016'),
    checkout: Date.parse('05-11-2016'))
    expect(t.dates).to eq([
      Date.parse('01-11-2016'),
      Date.parse('02-11-2016'),
      Date.parse('03-11-2016'),
      Date.parse('04-11-2016')])
  end
end
