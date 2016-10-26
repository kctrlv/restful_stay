require 'rails_helper'

RSpec.feature "Host can see all trips travelers booked with them" do
  scenario "host can see all their trips" do
    login_as_denverhost
    book_trip_for_listing

    visit reservations_path

    expect(current_path).to eq('/reservations')

    expect(page).to have_content("Guest Name")
    expect(page).to have_content("Traveler Johnson")

    expect(page).to have_content("Trip Start Date")
    expect(page).to have_content("2016-11-05")

    expect(page).to have_content("Trip End Date	")
    expect(page).to have_content("2016-11-07	")

    expect(page).to have_content("Listing Details")
    expect(page).to have_content("Cool Room")
  end

  scenario "host can see guest profile page" do
    login_as_denverhost
    book_trip_for_listing

    visit reservations_path

    expect(current_path).to eq('/reservations')

    expect(page).to have_content("Guest Name")
    expect(page).to have_content("Traveler Johnson")

    click_link "Traveler Johnson"

    expect(current_path).to eq("/profile/2")

    expect(page).to have_content("Traveler Johnson's Profile")
  end
end
