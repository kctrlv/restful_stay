require 'rails_helper'

RSpec.feature "Visitor visits Homepage" do
  scenario "visitor can see Create Account link and login form" do
    # as a visitor
    # when i visit '/' (Homepage)
    visit '/'

    # I should see a navbar with links to "Login" "Sign up" "About", and the website logo
    within(".navbar") do
      expect(page).to have_link("RESTful_stay")
      expect(page).to have_link("Login")
      expect(page).to have_link("Sign Up")
      expect(page).to have_link("About")
    end
    # I should see thumbnails with images of the destinations

    within (".cities") do
      expect(page).to have_css("img[src*='colorado_springs']")
      expect(page).to have_css("img[src*='denver']")
      expect(page).to have_css("img[src*='boulder']")
      expect(page).to have_css("img[src*='grand_junction']")
      expect(page).to have_css("img[src*='fort_collins']")
      expect(page).to have_css("img[src*='estes_park']")
    end

    # I should see a dropdown of city options
    expect(page).to have_select("cities_list", options: ["Colorado Springs",
                                                         "Denver",
                                                         "Boulder",
                                                         "Grand Junction",
                                                         "Fort Collins",
                                                         "Estes Park"])
  end
end
