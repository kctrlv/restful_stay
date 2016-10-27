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
    # I expect to see a list of available dates, with dates available on 11/05-06
    # within (".dates_available") do
    #   # expect(page).to have_css('.date', count: 11)
    #   expect(page).to have_content("2016-11-05")
    #   expect(page).to have_content("2016-11-06")
    # end
    # And I click the link to book the listing
    click_link "Book this Listing"
    # I expect my path to be "/trips/new"
    expect(current_path).to eq("/trips/new")
    # I expect to see the name of the listing
    expect(page).to have_content("Confirm your reservation for Cool Room")
    # And when I select "2016-11-05" from the checkin dropdown
    select "2016-11-05", from: "trip_checkin"
    # And when I select "2016-11-07" from the checkout dropdown
    select "2016-11-07", from: "trip_checkout"
    # And when I click "Book Trip"
    click_button "Book Trip"
    # I expect to be redirected to my trips index
    expect(current_path).to eq('/trips')
    expect(page).to have_content("Your Trips: ")
    # And I expect to see a flash message that my trip has been booked for Cool Room
    expect(page).to have_content("Your trip has been booked for Cool Room")
    # And I expect to see within my trips:
    within('.trips') do
      #  One trip
      expect(page).to have_css('.trip', count: 1)
      #  with the following attributes
      within('.trip') do
        #  Cool Room
        expect(page).to have_content("Cool Room")
        expect(page).to have_link("Cool Room", href: listing_path(listing.id))
        #  for the duration of 2 days
        expect(page).to have_content("Duration: 2 nights")
        #  On the dates of 2016-11-05 to 2016-11-07
        expect(page).to have_content("Checkin: 2016-11-05")
        expect(page).to have_content("Checkout: 2016-11-07")
        #  Hosted by: denverhost, with a link to their profile page
        expect(page).to have_content("Hosted by: denverhost")
        expect(page).to have_link('denverhost', href: profile_show_path(listing.host))
      end
    end
    # And when I go back to the listing of Cool Room
    click_link "Cool Room"
    # I expect to not see 11-05 and 11-06 on the available dates
    within (".dates_available") do
      expect(page).to_not have_content("2016-11-05")
      expect(page).to_not have_content("2016-11-06")
    end
  end

  scenario "traveler cannot book listing with start date after the end date" do
    login_as_traveler
    make_listing_for_booking

    visit('/')
    click_link "Denver"
    click_link "Cool Room"
    click_link "Book this Listing"
    select "2016-11-08", from: "trip_checkin"
    select "2016-11-04", from: "trip_checkout"
    click_button "Book Trip"
    expect(current_path).to eq("/trips/new")
    expect(page).to have_content("Please make sure your checkout date comes after the checkin date")
  end


  scenario "traveler cannot book an already-booked listing" do
    login_as_traveler
    trip = book_trip_for_listing

    visit('/')
    click_link "Denver"
    click_link "Cool Room"
    click_link "Book this Listing"

    select "2016-11-04", from: "trip_checkin"
    select "2016-11-08", from: "trip_checkout"
    click_button "Book Trip"
    expect(current_path).to eq("/trips/new")
    expect(page).to have_content("Dates within your selection have already been booked")
  end

  scenario "dates in the past do not show as available for a listing" do
    login_as_traveler
    make_past_listing
    visit('/')
    click_link "Fort Collins"
    click_link "Pioneer"
    within (".dates_available") do
      expect(page).to_not have_content("2016-10-22")
      expect(page).to_not have_content("2016-10-23")
    end
    click_link "Book this Listing"
    expect(find_field('trip_checkin')).not_to have_content('2016-10-22')
    expect(find_field('trip_checkin')).not_to have_content('2016-10-23')
    expect(find_field('trip_checkout')).not_to have_content('2016-10-22')
    expect(find_field('trip_checkout')).not_to have_content('2016-10-23')
  end
end
