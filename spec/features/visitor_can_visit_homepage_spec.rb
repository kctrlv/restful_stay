require 'rails_helper'

RSpec.feature "Visitor visits Homepage" do
  scenario "visitor can see Create Account link and login form" do
    visit '/'

    within(".navbar") do
      expect(page).to have_link("RESTful_stay")
      expect(page).to have_link("Login")
      expect(page).to have_link("Sign Up")
      expect(page).to have_link("About")
    end

    within (".cities") do
      expect(page).to have_css(".city", count: 6)
    end
  end
end
