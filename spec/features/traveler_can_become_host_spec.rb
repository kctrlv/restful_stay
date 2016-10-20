require 'rails_helper'

RSpec.feature "Traveler Becomes Host" do
  scenario "traveler becomes host and sees links to their listings" do
    # As a logged in traveler
    user = create(:user, status: "active", password: 'password')
    trav_role = create(:role, name: "traveler")
    host_role = create(:role, name: "host")

    user.roles << trav_role
    expect(user.traveler?).to eq(true)
    expect(user.host?).to eq(false)

    visit login_path
    fill_in "Email", with: user.email_address
    fill_in "Password", with: user.password
    click_on "login-button"

    # When I visit '/listings'
    visit '/listings'
    # I should see a 404 error
    expect(page.status_code).to eq(404)
    # And when I go back to the homepage
    visit '/'
    # When I click 'Become a Host'
    click_link "Become a Host"
    # I should still be on the homepage
    expect(user.host?).to eq(true)
    expect(current_path).to eq('/')
    # When I click "My Listings"
    click_link "Listings"
    # I should expect to be at '/listings'
    expect(current_path).to eq("/listings")
    # And I should expect to see a link to create a new listing
    expect(page).to have_link("Create Listing")
  end
end
