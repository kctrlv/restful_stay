require 'rails_helper'

RSpec.feature "Suspended user can not log in" do
  scenario "when a suspended user trys to log in the session is cleared" do
    user = create(:user, status: "suspended")

    visit '/login'

    #And I fill out the login form
    fill_in "Email", with: user.email_address
    fill_in "Password", with: user.password
    #And and I click on log in button
    click_button "Login"

    expect(current_path).to eq('/login')

    expect(page).to have_content("Your account is temporarily suspended")
  end
end
