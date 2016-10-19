require 'rails_helper'

RSpec.feature "Visitor visits Homepage" do
  scenario "visitor can see Create Account link and login form" do
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
    # and I fill in "Birthdate" with "07/07/1907"
    # and I fill in phone number with "5551234567"
    # and I click "Submit"
    #
    # then I should expect to be on '/confirmation'
    # and my account should be created but inactive
    # And I should see instructions to enter my confirmation code
    # And I should have received a text message with a confirmation code
    #
    # When I enter the confirmation code
    # And I click "Submit"
    # Then I should be redirected to "/dashboard"
    # And I should see a "Chad" in the navbar


  end
end
