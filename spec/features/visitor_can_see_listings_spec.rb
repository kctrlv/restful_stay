require 'rails_helper'

RSpec.feature "Visitor sees Listings" do
  scenario "visitor clicks on a city and sees its listings" do
    # As a visitor
    # Given that a particular city has listings
    city = City.find_by(name: "Colorado Springs")
    # 5.times { create(:listing, city: city) }
    create_list(:listing, 5, city: city)
    # When I visit "/"
    visit('/')
    # I expect to see a list of cities with listings
    within(".cities") do
      expect(page).to have_css('.city', count: 6)
    end
    # And I click on a city link
    click_link "Colorado Springs"
    # I expect my path to be "/cities/colorado_springs"
    expect(current_path).to eq("/cities/colorado-springs")
    # I expect to see a list of listings available in this city for the dates selected
    expect(page).to have_content("Listings for Colorado Springs")
    within(".listings") do
      expect(page).to have_css('.listing', count: 5)
    end
    Listing.all.each do |listing|
      expect(page).to have_content(listing.name)
    end
  end
end
