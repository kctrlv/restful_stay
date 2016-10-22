FactoryGirl.define do
  factory :day do
    date Faker::Date.between(Date.today, 1.year.from_now)
  end
end
