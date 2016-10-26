require 'rails_helper'

RSpec.feature "Host can see all trips travelers booked with them" do
  scenario "host can see all their trips" do
    login_as_denverhost
    book_trip_for_listing

    visit reservations_path

    expect(current_path).to eq('something')

  end
end

















# user = User.find_by(first_name: "denverhost")
# login(user, 'denverhost')
#
# click_link "Listings"
#
# expect(current_path).to eq('/listings')
#
# click_link "Create Listing"
#
# expect(current_path).to eq('/listings/new')
#
# fill_in "Name", with: "My Listing"
# fill_in "Description", with: "Testing"
# fill_in "Price per night", with: "19.99"
# select "2016-10-26", from: "listing[start_date]"
# select "2016-10-29", from: "listing[end_date]"
#
# click_button "Create Listing"
#
# visit '/dashboard'
#
# click_link "Reservations"
#
# expect(current_path).to eq("/reservations")
#
# expect(page).to have_content("2016-11-05")
# expect(page).to have_content("2016-11-07")
# expect(page).to have_content("Traveler")
