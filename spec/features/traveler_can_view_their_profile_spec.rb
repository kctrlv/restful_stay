require 'rails_helper'

RSpec.feature "Traveler Can View Their Profile" do
  scenario "traveler can see their dashboard and information" do
    # As a logged in traveler
    user = create(:user, status: "active", password: 'password')
    trav_role = create(:role, name: "traveler")

    user.roles << trav_role
    expect(user.traveler?).to eq(true)
    expect(user.host?).to eq(false)

    visit login_path
    fill_in "Email", with: user.email_address
    fill_in "Password", with: user.password
    click_on "login-button"

    # When I click on "My name"
    click_on user.name
    # I expect my path to be "/dashboard"
    expect(current_path).to eq('/dashboard')
    # I expect to see my profile picture
    expect(page).to have_css("img[src*=#{user.picture_url}]")
    # I expect to see my profile description
    expect(page).to have_content(user.description)
    # I expect to see a list of my trips 
    
    # I expect to see a button/link to "Edit Profile"
    expect(page).to have_link("Edit Profile")
    # I expect to see a button/link to "View Profile"
    expect(page).to have_link("View Profile")
    # When I click on "View Profile"
    click_link "View Profile"
    # I expect my path to be "/profile/:user_id"
    expect(current_path).to eq("/profile/:user_id")
    # I expect to see my profile image 
    expect(page).to have_css("img[src*=#{user.picture_url}]")
    # I expect to see my description    
    expect(page).to have_content(user.description)
  end
end
