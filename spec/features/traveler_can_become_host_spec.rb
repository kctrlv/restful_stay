require 'rails_helper'

RSpec.feature "Traveler Becomes Host" do
  scenario "traveler becomes host and sees links to their listings" do
    # As a traveler
    user = create(:user, status: "active")
    role = create(:role, name: "traveler")
    user.roles << role
    expect(user.traveler?).to eq(true)
    expect(user.host?).to eq(false)
    # When I visit '/listings'
    visit '/listings'
    # I should see a 404 error
    expect(page.status_code).to eq(404)
    # And when I go back to the homepage
    visit '/'
    # When I click 'Become a Host'
    click_link "Become a Host"
    # I should see a link in my navbar for "My Listings"
    # When I click "My Listings"
    # I should expect to be at '/listings'
    # And I should expect to see a link to create a new listing
  end
end
