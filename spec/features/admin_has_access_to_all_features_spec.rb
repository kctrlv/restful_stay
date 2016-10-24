require 'rails_helper'

RSpec.feature "Admin can see and manipulate all features of the site" do
  scenario "admin can sign in and visit admin dashboard" do
    admin = create(:user, status: "active")
    admin.roles << Role.find(3)
  
    # As an admin, I will log in and expect to be redirected to admin dashboard
    visit '/login'
    # And I enter my information
    fill_in "Email", with: admin.email_address
    fill_in "Password", with: admin.password
    #And and I click on log in button
    click_button "Login"
    #I expect to be in the 'admin/dashboard'
    expect(current_path).to eq('/admin/dashboard')
  end
  
  scenario "when admin logs in, we expect page to have Admin Info, Listings, Users" do
    admin = create(:user, status: "active")
    admin.roles << Role.find(3)
    # As an admin, I will log in and expect to be redirected to admin dashboard
    login_user(admin)
    #I expect to be in the 'admin/dashboard'
    expect(current_path).to eq('/admin/dashboard')
    # I expect page to have the following contents : Admin info, listings, users, create city
    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_content("Manage Users")
    expect(page).to have_content("Manage Listings")
    expect(page).to have_content("Manage Cities")
  end
  
    xscenario "admin should be able to create a new city" do
  end
end