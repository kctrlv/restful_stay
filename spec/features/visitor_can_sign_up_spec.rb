require 'rails_helper'

RSpec.feature "Visitor Signs Up" do
  scenario "visitor can become an inactive user" do
    VCR.use_cassette("confirmation_code") do
      visit '/'
      click_link "Sign Up"
      expect(current_path).to eq("/signup")
      expect(page).to have_css('form')
      fill_in "First name", with: "Chad"
      fill_in "Last name", with: "Clancey"
      fill_in "Email address", with: "cc007@gmail.com"
      fill_in "Password", with: "clanceytime"
      fill_in "Phone number", with: '5551234567'
      click_button "Sign Up"
      expect(current_path).to eq("/confirmation")
      expect(page).to have_content("Please enter the confirmation code you received")
    end
  end

  scenario "visitor cannot signup without all attributes" do
    VCR.use_cassette("confirmation_code") do
      visit '/'
      click_link "Sign Up"
      expect(current_path).to eq("/signup")
      expect(page).to have_css('form')
      fill_in "First name", with: ""
      fill_in "Last name", with: ""
      fill_in "Email address", with: "blahblahblah"
      fill_in "Password", with: "clanceytime"
      fill_in "Phone number", with: '5551234567'
      click_button "Sign Up"
      expect(current_path).to eq("/signup")
    end
  end
end
