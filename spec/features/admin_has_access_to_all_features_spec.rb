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

  scenario "admin should be able to go to Manage Users page" do
    admin = create(:user, status: "active")
    admin.roles << Role.find(3)
    # As an admin, I will log in and expect to be redirected to admin dashboard
    login_user(admin)
    #I expect to be in the 'admin/dashboard'
    expect(current_path).to eq('/admin/dashboard')
    # When I click Link Manager Users
    click_link "Manage Users"
    # I expect to be redirected to '/admin/dashboard/manage_users'
    expect(current_path).to eq('/admin/dashboard/manage_users')
    # I expect page to have content Manage Users
    expect(page).to have_content("Manage Users")
    # I expect to see a list of all users and their status
    expect(page).to have_content("Edit")
    expect(page).to have_content("First name")
    expect(page).to have_content("Last name")
    expect(page).to have_content("Status")
  end

  scenario "admin be able to see a specific user page" do
    admin = create(:user, status: "active")
    admin.roles << Role.find(3)
    # As an admin, I will log in and expect to be redirected to admin dashboard
    login_user(admin)
    #I expect to be in the 'admin/dashboard'
    expect(current_path).to eq('/admin/dashboard')
    # When I click Link Manager Users
    click_link "Manage Users"
    # I expect to be redirected to '/admin/dashboard/manage_users'
    expect(current_path).to eq('/admin/dashboard/manage_users')
    # I expect page to have content Manage Users
    expect(page).to have_content("Manage Users")
    # When I click on the user id I should be redirected to admin user show page
    click_link "1"
    expect(current_path).to eq('/admin/dashboard/manage_users/1/edit')
  end

  scenario "admin update status of specific user" do
    admin = create(:user, status: "active")
    admin.roles << Role.find(3)
    user_1 = create(:user, first_name: "Raphael", last_name: "Barbo",  status: 'active')
    # As an admin, I will log in and expect to be redirected to admin dashboard
    login_user(admin)
    #I expect to be in the 'admin/dashboard'
    expect(current_path).to eq('/admin/dashboard')
    # When I click Link Manager Users
    click_link "Manage Users"
    # I expect to be redirected to '/admin/dashboard/manage_users'
    expect(current_path).to eq('/admin/dashboard/manage_users')
    # I expect page to have content Manage Users
    expect(page).to have_content("Manage Users")
    # When I click on the user id I should be redirected to admin user show page
    click_link "#{user_1.id}"
    expect(current_path).to eq("/admin/dashboard/manage_users/#{user_1.id}/edit")
    # And I update user status to suspended
    select "suspended", from: "user[status]"
    # And I click on "Update User Profile"
    click_button "Update User Profile"
    # I expect to be redirected to admin manage user dashboard
    expect(current_path).to eq('/admin/dashboard/manage_users')
    # I expect user_1 status to equal suspended
    expect(user_1.reload.status).to eq('suspended')
    # expect(page).to have_content('suspended')
  end

  scenario "admin can delete listing of specific host" do
    admin = create(:user, status: "active")
    admin.roles << Role.find(3)
    listing1 = create(:listing, name: "listing1", host_id: 3)
    listing2 = create(:listing, name: "listing2", host_id: 3)
    # As an admin, I will log in and expect to be redirected to admin dashboard
    login_user(admin)
    #I expect to be in the 'admin/dashboard'
    expect(current_path).to eq('/admin/dashboard')
    # When I click Link Manager Users
    click_link "Manage Listings"
    # I expect to be redirected to '/admin/dashboard/manage_users'
    expect(current_path).to eq('/admin/dashboard/manage_listings')
    # I expect page to have content Manage Users
    expect(page).to have_content("Manage Listings")
    # When I click on the listing id I should be redirected to admin listing show page
    expect(page).to have_content("listing1")
    click_link "#{listing1.id}"
    expect(current_path).to eq("/admin/dashboard/manage_listings/#{listing1.id}")
    # And I click on "Delete Listing"
    click_link "Delete Listing"
    # I expect to be redirected to admin manage listing dashboard
    expect(current_path).to eq('/admin/dashboard/manage_listings')
    # I expect user_1 status to equal suspended
    expect(page).to_not have_content("listing1")
  end
end
