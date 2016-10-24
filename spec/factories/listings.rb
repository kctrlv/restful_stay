FactoryGirl.define do
  factory :listing do
    name { Faker::Pokemon.location }
    description { Faker::Lorem.paragraph }
    image_url { Faker::Avatar.image }
    price_per_night { Faker::Number.decimal(2) }
    city
    host
  end
end
