FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email_address Faker::Internet.email
    password 'password'
    phone_number Faker::PhoneNumber.cell_phone
    description Faker::Lorem.paragraph
    picture_url Faker::Avatar.image
    status "active"
  end
  
  factory :admin do
    name 'admin'
  end
  
  factory :traveler do
    name 'traveler'
  end
  
  factory :host do
    name 'host'
  end
end

# describe "..." do
#   let(:user) { create :user }
#   let(:manager) { create :manager_role }
# 
#   before(:each) do
#     user.roles << manager
#   end
# 
#   it "should ...." do
#     # etc.
#   end
# end
