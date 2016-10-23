require 'rails_helper'

RSpec.feature "Traveler Books Room" do
  scenario "traveler books listing and sees it in their trips" do
    # As a Traveler
    login_as_traveler
    # Given that there is a listing for "Cool Room" in Denver
    listing = make_listing_for_booking
    # When I visit "/"
    visit('/')
    # I expect to see a list of cities with available listings
    within(".cities") do
      expect(page).to have_css('.city', count: 6)
    end
    # And I click "Denver"
    click_link "Denver"
    # And I expect to see the listings for Denver
    within(".listings") do
      expect(page).to have_css('.listing', count: 3)
    end
    # And I click the listing for "Cool Room"
    click_link "Cool Room"
    # I expect my path to be "/listings:id"
    expect(current_path).to eq("/listings/#{listing.id}")
    # I expect to see a list of available dates
    within (".dates_available") do
      expect(page).to have_css('.date', count: 11)
    end
    # And I click the link to book the listing
    click_link "Book this Listing"
    # I expect my path to be "/trips/new"
    expect(current_path).to eq("/trips/new")
    # I expect to see the name of the listing
    # I expect to see an image(s) associated with the listing
    # I expect to see a description of the listing
    # I expect to see a link to "Book this Listing"
    #
    # When I click on "Book this Listing"
    # I expect to see a flash message "Listing Name Booked!"
    # I expect my path to be "/trips/:user_id"
    #
    # I expect to see a list of my trips (most often ppl will only have one active trip)
    # I expect to see "Listing Name"
    # I expect to see the start and end date for the listing I just booked

  end
end
