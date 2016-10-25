FactoryGirl.define do
  factory :user, aliases: [:host, :guest] do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email_address Faker::Internet.email
    password 'password'
    phone_number Faker::PhoneNumber.cell_phone
    description Faker::Lorem.paragraph
    picture_url Faker::Avatar.image
    status "inactive"
  end
end
