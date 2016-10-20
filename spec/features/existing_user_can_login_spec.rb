require 'rails_helper'

RSpec.feature "An existing user can login" do
  scenario "they can enter credentials and access their dashboard" do
#  As a user with an existing account
    user = create(:user, status: 'active')

#  When I visit '/'
    visit '/'

#  When I click on "Login"
    click_on "Login"

#  I expect current path to be "/login"
    expect(current_path).to eq("/login")

#  then, when I fill in email with my email
    fill_in "Email", with: user.email_address

#  and I fill in password with my password
    fill_in "Password", with: user.password

#  and I click "Login"
    click_button "Login"

#  I expect current path "/dashboard"
    expect(current_path).to eq("/dashboard")

#  I expect to see "Trips" in the navbar
#  I expect to see "Messages" in the navbar
#  And I expect to see my first name in the navbar
    within(".navbar") do
      expect(page).to have_content("Trips")
      expect(page).to have_content("Messages")
      expect(page).to have_content("#{user.first_name}")
    end
  end
end
