require 'rails_helper'

RSpec.feature "User logs in and out" do
  scenario "user can log in" do
    user = create(:user)
    visit '/'
    click_on "Login"
    fill_in "Email", with: user.email_address
    fill_in "Password", with: user.password
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
    user = create(:user)
    login_user(user)
    within(".navbar") do
      expect(page).to have_content("Logout")
    end
    click_on "Logout"
    expect(current_path).to eq("/")
    within(".navbar") do
      expect(page).to_not have_content("#{user.first_name}")
      expect(page).to_not have_content("Trips")
      expect(page).to_not have_content("Messages")
      expect(page).to_not have_content("Logout")
    end
    within(".navbar") do
      expect(page).to have_content("Login")
      expect(page).to have_content("Sign Up")
      expect(page).to have_content("About")
    end
  end

  scenario "user cannot login when credentials are not correct" do
    user = create(:user)
    visit '/'
    click_on "Login"
    fill_in "Email", with: "joseph@gmail.com"
    fill_in "Password", with: "notmypassword"
    click_button "Login"
  end
end
