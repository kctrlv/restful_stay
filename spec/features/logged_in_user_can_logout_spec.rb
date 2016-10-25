require 'rails_helper'

RSpec.feature "User logs in and out" do
  scenario "user can log in" do
    # As a registered user
    user = create(:user)
    #When I visit the homepage
    visit '/'
    #And click on login
    click_on "Login"
    #And I fill out the login form
    fill_in "Email", with: user.email_address
    fill_in "Password", with: user.password
    #And and I click on log in button
    click_button "Login"

    within(".navbar") do
      expect(page).to have_content("Logout")
    end

    within(".navbar") do
      expect(page).to have_content("#{user.first_name}")
      expect(page).to have_content("Trips")
      expect(page).to have_content("Messages")
      expect(page).to have_content("Logout")
    end
  end

  scenario "user can log out" do
    # As a registered user
    user = create(:user)
    # I login
    login_user(user)
    # I should see a link on the navbar "Logout"
    within(".navbar") do
      expect(page).to have_content("Logout")
    end
    # When I click on "Logout"
    click_on "Logout"
    # I should expect to be directed to the homepage
    expect(current_path).to eq("/")
    # I expect tp not see my first name, trips, or messages in navbar
    within(".navbar") do
      expect(page).to_not have_content("#{user.first_name}")
      expect(page).to_not have_content("Trips")
      expect(page).to_not have_content("Messages")
      expect(page).to_not have_content("Logout")
    end
    # I expect to see links "login" "sign up" and "about"
    within(".navbar") do
      expect(page).to have_content("Login")
      expect(page).to have_content("Sign Up")
      expect(page).to have_content("About")
    end
  end

  scenario "user cannot login when credentials are not correct" do
    # As a registered user
    user = create(:user)
    #When I visit the homepage
    visit '/'
    #And click on login
    click_on "Login"
    #And I fill out the login form
    fill_in "Email", with: "joseph@gmail.com"
    fill_in "Password", with: "notmypassword"
    #And and I click on log in button
    click_button "Login"
  end
end
