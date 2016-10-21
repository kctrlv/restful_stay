require 'rails_helper'

RSpec.feature "Traveler Can View and Edit Their Profile" do
  scenario "traveler can see their dashboard and view profile" do
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
    click_on "#{user.first_name}"
    # I expect my path to be "/dashboard"
    expect(current_path).to eq('/dashboard')
    # I expect to see my profile picture
    expect(page).to have_css("img[src=\"#{user.picture_url}\"]")
    # I expect to see my profile description
    expect(page).to have_content(user.description)
    # I expect to see a list of my trips 
    expect(page).to have_content("Trips:")
    # I expect to see a button/link to "Edit Profile"
    expect(page).to have_link("Edit Profile")
    # I expect to see a button/link to "View Profile"
    expect(page).to have_link("View Profile")
    # When I click on "View Profile"
    click_link "View Profile"
    # I expect my path to be "/profile/:user_id"
    expect(current_path).to eq("/profile/#{user.id}")
    # I expect to see my profile image 
    expect(page).to have_css("img[src=\"#{user.picture_url}\"]")
    # I expect to see my description    
    expect(page).to have_content(user.description)
  end
  
  scenario "traveler can edit profile" do
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
    click_on "#{user.first_name}"
    # I expect my path to be "/dashboard"
    expect(current_path).to eq('/dashboard')
    
    # I expect to see a button/link to "Edit Profile"
    expect(page).to have_link("Edit Profile")
    # When I click on "Edit Profile"
    click_link "Edit Profile"
    # I expect my path to be "/profile/:user_id"
    expect(current_path).to eq("/profile/#{user.id}/edit")
    
    fill_in "First Name", with: "Bob"
    click_on "Update My Profile"
    expect(current_path).to eq("/profile/#{user.id}")
    save_and_open_page
    expect(page).to have_content("Bob")
    
  end
end
