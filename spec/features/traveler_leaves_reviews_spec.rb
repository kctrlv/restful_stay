require 'rails_helper'

RSpec.feature "Traveler Leaves Reviews" do
  scenario "traveler can leave a review for a trip" do
    traveler_books_two_trips_with_denverhost
    visit '/'
    login_as_traveler
    visit '/trips'
    within('.trips') do
      within(".trip:nth-child(1)") do
        expect(page).to have_content("Duration: 3 nights")
        click_link "Leave Review"
      end
    end
    trip = Trip.find_by(checkin: "2016-10-31")
    expect(current_path).to eq("/trips/#{trip.id}/review/new")
    fill_in "Subject", with: "This place was good."
    fill_in "Body", with: "I really enjoyed staying here, highly recommend."
    click_button "Submit"

    within('.trips') do
      within(".trip:nth-child(1)") do
        expect(page).to have_content("Duration: 3 nights")
        expect(page).to have_content("Show Review")
        expect(page).to have_content("Edit Review")
        expect(page).to have_content("Delete Review")
      end
    end
  end

  scenario "traveler can see a review for a trip" do
    traveler_books_two_trips_with_denverhost
    traveler_leaves_a_review_for_denverhost
    visit '/'
    login_as_traveler
    visit '/trips'
    within('.trips') do
      within(".trip:nth-child(1)") do
        expect(page).to have_content("Duration: 3 nights")
        click_link "Show Review"
      end
    end
    expect(page).to have_content("Top-Notch Hosting")
    expect(page).to have_content("This was a good place")
    expect(page).to have_content("Reviewed by: Traveler")
    expect(page).to have_content("Hosted by: denverhost")
  end

  scenario "traveler can delete a review for a trip" do
    traveler_books_two_trips_with_denverhost
    traveler_leaves_a_review_for_denverhost
    visit '/'
    login_as_traveler
    visit '/trips'
    within('.trips') do
      within(".trip:nth-child(1)") do
        expect(page).to have_content("Duration: 3 nights")
        click_link "Delete Review"
      end
    end
    expect(current_path).to eq("/trips")
    within('.trips') do
      within(".trip:nth-child(1)") do
        expect(page).to have_content("Duration: 3 nights")
        expect(page).to have_link("Leave Review")
      end
    end
  end

  scenario "traveler can edit a review for a trip" do
    traveler_books_two_trips_with_denverhost
    traveler_leaves_a_review_for_denverhost
    visit '/'
    login_as_traveler
    visit '/trips'
    within('.trips') do
      within(".trip:nth-child(1)") do
        expect(page).to have_content("Duration: 3 nights")
        click_link "Edit Review"
      end
    end
    trip = Trip.find_by(checkin: "2016-10-31")
    expect(current_path).to eq("/trips/#{trip.id}/review/edit")
    fill_in "Subject", with: "This place was really good."
    fill_in "Body", with: "I am a cat."
    click_button "Submit"
    expect(page).to have_content("This place was really good.")
    expect(page).to have_content("I am a cat.")
    expect(page).to have_content("Reviewed by: Traveler")
    expect(page).to have_content("Hosted by: denverhost")
  end
end
