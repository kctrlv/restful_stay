FactoryGirl.define do
  factory :user do
    first_name: Faker::Name.first_name
    last_name:
    email_address:
    password_digest:
    phone_number:
    description:
    picture_url:
    status:
  end
end
