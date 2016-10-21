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
      fill_in "First name", with: "Chad"
      # and I fill in "Last Name" with "Clancey"
      fill_in "Last name", with: "Clancey"
      # and I fill in "Email Address" with "cc007@gmail.com"
      fill_in "Email address", with: "cc007@gmail.com"
      # and I fill in "Password" with "clanceytime"
      fill_in "Password", with: "clanceytime"
      # and I fill in phone number with "5551234567"
      fill_in "Phone number", with: '5551234567'
      # and I click "Submit"
      click_button "Sign Up"
      #
      # then I should expect to be on '/confirmation'
      expect(current_path).to eq("/confirmation")
      # and my account should be created but inactive - tested seperately
      # And I should see instructions to enter my confirmation code
      expect(page).to have_content("Please enter the confirmation code you received")
    end
  end

  # scenario "visitor can confirm with two-factor auth" do
  #   # As an inactive user
  #
  #   # And I should have received a text message with a confirmation code
  #   # When I enter the confirmation code
  #   fill_in "Code", with: 1234
  #
  #   # And I click "Submit"
  #   click_button "Confirm"
  #   # Then I should be redirected to "/dashboard"
  #   expect(current_path).to eq("/dashboard")
  #   # And I should see a "Chad" in the navbar
  #   within ".navbar" do
  #     expect(page).to have_content("Chad")
  #   end
  # end
end
