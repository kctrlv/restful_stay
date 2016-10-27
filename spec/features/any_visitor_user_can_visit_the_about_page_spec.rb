require 'rails_helper'

RSpec.feature "any visitor/user can visit the About page" do
  scenario "user can see visit about page" do
    user = create(:user)
    login_user(user)
    visit '/about'
    expect(current_path).to eq(about_path)
    expect(page).to have_content("Created by: Brian Heim, David Davydov, Nate Anderson, and Raphael Barbo")
  end

  scenario "visitor can see visit about page" do
    visit '/about'
    expect(current_path).to eq(about_path)
    expect(page).to have_content("Created by: Brian Heim, David Davydov, Nate Anderson, and Raphael Barbo")
  end
end
