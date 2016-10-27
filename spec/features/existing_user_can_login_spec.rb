require 'rails_helper'

RSpec.feature "An existing user can login" do
  scenario "they can enter credentials and access their dashboard" do
    user = create(:user, status: 'active')
    visit '/'
    click_on "Login"
    expect(current_path).to eq("/login")
    fill_in "Email", with: user.email_address
    fill_in "Password", with: user.password
    click_button "Login"
    expect(current_path).to eq("/")
    within(".navbar") do
      expect(page).to have_content("Trips")
      expect(page).to have_content("Messages")
      expect(page).to have_content(user.first_name)
    end
  end
end
