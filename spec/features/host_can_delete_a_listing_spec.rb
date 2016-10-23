require 'rails_helper'

RSpec.feature "Host can delete listing" do
  scenario "they can delete an existing listing" do
    # As a Host
    login_as_host
    listing1 = create(:listing, host_id: 3)
    listing2 = create(:listing, host_id: 3)

    # As a Host
    # When I click "Listings"
    click_on "Listings"
    # I expect my path to be "/listings
    expect(current_path).to eq('/listings')
    # click link to "Remove Listing"
    within ".listings" do
      within "li:nth-child(1)" do
        click_link "Remove Listing"
      end
    end  
    
    within(".listings") do
      expect(page).to_not have_link("#{listing1.name}")
      expect(page).to have_link("#{listing2.name}")
    end
  end
end