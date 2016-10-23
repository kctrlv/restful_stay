FactoryGirl.define do
  factory :trip do
    checkin "2016-10-23"
    checkout "2016-10-26"
    listing
    guest
  end
end
