FactoryGirl.define do
  factory :user do
    first_name "Joe"
    last_name "Delaware"
    username
    password "123foo456"
    password_confirmation "123foo456"
    gender "Other"
    street_address
    city "Salt Lake City"
    state "Utah"
    zip_code "84104"
  end
end
