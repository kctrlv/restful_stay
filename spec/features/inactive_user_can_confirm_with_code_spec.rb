
RSpec.feature "Visitor can active account" do
  scenario "visitor cannot confirm with wrong code" do
    VCR.use_cassette("confirmation_code") do
      # As a vistor
      # When a visit '/signup'
      visit '/signup'
      # and I fill first_name, last_name, email, and password
      fill_in "First name", with: "Joseph"
      fill_in "Last name", with: "Miller"
      fill_in "Email address", with: "jmiller@turing.com"
      fill_in "Password", with: "password"
      fill_in "Phone number", with: "+10000000000"

      click_button "Sign Up"

      expect(current_path).to eq('/confirmation')

      within(".navbar") do
        expect(page).to have_content("Joseph")
        click_link "Joseph"
        expect(current_path).to eq('/confirmation')
      end
    end
  end

  scenario "visitor cannot confirm with wrong code" do
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
      fill_in "Code", with: 00000
      # And I click "Confirm"
      click_button "Confirm"
      # Then I should be re-rendered to "/confirmation"
      expect(current_path).to eq("/confirmation")
    end
  end

  scenario "visitor cannot confirm with wrong code" do
    VCR.use_cassette("confirmation_code") do
      # As a visitor
      # when I visit homepage
      visit '/confirmation'
      # I expect to receive a 404 error page
      expect(page.status_code).to eq(404)
    end
  end

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
