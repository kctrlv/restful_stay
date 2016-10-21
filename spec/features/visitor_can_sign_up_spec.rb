require 'rails_helper'

RSpec.feature "Visitor Signs Up" do
  scenario "visitor can become an inactive user" do
    VCR.use_cassette("confirmation_code") do
      # As a visitor
      # When I visit '/'
      visit '/'
      # and I click link to "Sign Up"
      click_link "Sign Up"
      # I expect current path to be '/signup'
      expect(current_path).to eq("/signup")
      # I expect to see a form
      expect(page).to have_css('form')
      # and I fill in "First Name" with "Chad"
      fill_in "First Name", with: "Chad"
      # and I fill in "Last Name" with "Clancey"
      fill_in "Last Name", with: "Clancey"
      # and I fill in "Email Address" with "cc007@gmail.com"
      fill_in "Email Address", with: "cc007@gmail.com"
      # and I fill in "Password" with "clanceytime"
      fill_in "Password", with: "clanceytime"
      # and I fill in phone number with "5551234567"
      fill_in "Phone Number", with: '5551234567'
      # and I click "Submit"
      click_button "Sign Up"
      # then I should expect to be on '/confirmation'
      expect(current_path).to eq("/confirmation")
      # and my account should be created but inactive - tested seperately
      # And I should see instructions to enter my confirmation code
      expect(page).to have_content("Please enter the confirmation code you received")
    end
  end

  scenario "visitor cannot signup without all attributes" do
      # As a visitor
      # When I visit '/'
      visit '/'
      # and I click link to "Sign Up"
      click_link "Sign Up"
      # I expect current path to be '/signup'
      expect(current_path).to eq("/signup")
      # I expect to see a form
      expect(page).to have_css('form')
      # and I fill in "First Name" with "Chad"
      fill_in "First Name", with: ""
      # and I fill in "Last Name" with "Clancey"
      fill_in "Last Name", with: ""
      # and I fill in "Email Address" with "cc007@gmail.com"
      fill_in "Email Address", with: "blahblahblah"
      # and I fill in "Password" with "clanceytime"
      fill_in "Password", with: "clanceytime"
      # and I fill in phone number with "5551234567"
      fill_in "Phone Number", with: '5551234567'
      # and I click "Submit"
      click_button "Sign Up"
      #
      # then I should expect to be on '/signup path again'
      #since it will re-render new
      expect(current_path).to eq("/signup")
  end
end
