
RSpec.feature "Visitor can active account" do
  scenario "visitor can confirm with two-factor auth" do
    VCR.use_cassette("confirmation_code") do
      # As an inactive user
      user = create(:user, verification_code: 540958)
      # when I visit homepage
      visit '/'
      # and I click link to "Login"
      click_link "Login"
      #And I fill out the login form
      fill_in "Email", with: user.email_address
      fill_in "Password", with: user.password
      #And and I click on log in button
      click_button "Login"
      # I expect to be redirect to the confirmation page
      expect(current_path).to eq('/confirmation')
      # And I should have received a text message with a confirmation code
      # When I enter the confirmation code
      fill_in "Code", with: 540958
      # And I click "Confirm"
      click_button "Confirm"
      # Then I should be redirected to "/dashboard"
      expect(current_path).to eq("/dashboard")
      # And I should see a "Chad" in the navbar
      within ".navbar" do
        expect(page).to have_content(user.first_name)
      end
    end
  end
end
