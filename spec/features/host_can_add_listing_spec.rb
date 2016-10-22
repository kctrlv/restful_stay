require 'rails_helper'

RSpec.feature "Host creates listing" do
  scenario "they can create a listing and see it on their dashbaord" do
    # As a Host
    login_as_host
    # When I click "Listings"
    click_link "Listings"
    # I expect my path to be "/listings"
    expect(current_path).to eq("/listings")
    # The following is best for viewing a listing
    # I expect to see link/button to "Add a Listing"
    # I expect to see a list of my current listings
    # I expect to see a link/button next to each listing to "Edit Listing"
    # I expect to see a link/button next to each listing to "Remove Listing"
    # I expect to see a link/button next to each lisitng to "View trips associated with this listing"
    #
    # When I click on "Add Listing"
    click_link "Create Listing"
    # I expect my path to be "/listings/new"
    expect(current_path).to eq("/listings/new")
    # I expect to see a form to fill in information about my new listing
    #
    # When I fill in name with "Turing Basement"_
    fill_in "Name", with: "Turing Basement"
    # When I fill in the Image URL field with a picture of the turing basement
    fill_in "Image URL", with: ""
    # When I fill in Location with "Denver"
    select "Denver", from: "cities"
    # When I fill in Description with "Coding Dungeon"
    fill_in "Description", with: "Coding Dungeon"
    # When I fill in the price per night as $39
    fill_in "Price per night", with: 39.00

    # When I fill in dates available?
    select "2016-05-06", from: "date_start"
    select "2016-05-20", from: "date_end"

    # When I click on "Create Listing"
    click_button "Create Listing"

    # I expect to see my listing
    expect(page).to have_content("Turing Basement")
  end
end
