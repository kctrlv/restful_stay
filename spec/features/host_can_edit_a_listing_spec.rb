require 'rails_helper'

RSpec.feature "Host can edit listing" do
  scenario "they can edit an existing listing and see it on their dashboard" do
    # As a Host
    login_as_host
    listing1 = create(:listing, host_id: 3)
    listing2 = create(:listing, host_id: 3)
    # As a Host
    # When I click "Listings"
    click_on "Listings"
    # I expect my path to be "/listings
    expect(current_path).to eq('/listings')
    # I expect to see link/button to "Add a Listing"
    expect(page).to have_link("Create Listing")
    # I expect to see a list of my current listings
    # I expect to see a link/button next to each listing to "Edit Listing"
    # I expect to see a link/button next to each listing to "Remove Listing"
    within(".listings") do
      expect(page).to have_link("#{listing1.name}")
      expect(page).to have_link("#{listing2.name}")
    end

    # When I click on "Edit Listing" next to a current listing
    within ".listings" do
      within "li:nth-child(1)" do
        expect(page).to have_link("Edit Listing")
        expect(page).to have_link("Remove Listing")
      end
      within "li:nth-child(2)" do
        expect(page).to have_link("Edit Listing")
        expect(page).to have_link("Remove Listing")
      end
    end  
    # When I click on "Edit Listing" next to a current listing
    within ".listings" do
      within "li:nth-child(1)" do
        click_link "Edit Listing"
      end
    end
    
    # I expect my path to be "listings/:user_id/:listing_id"
    expect(current_path).to eq("/listings/#{listing1.id}/edit")
    # I expect to see a form to edit parameters of the listing
    # When I fill in name with "The Blakement"
    fill_in "Name", with: "The Blakement"
    # And I click on "Update Listing"
    click_on "Update Listing"
    # I expect my path to be "/listings/:user_id"
    expect(current_path).to eq("/listings/#{listing1.id}")
    # And I expect the listing I edited to now have the name "The Blakement"
    expect(page).to have_content("The Blakement")
    save_and_open_page  
  end
end