require 'rails_helper'

RSpec.feature "any visitor/user can visit the About page" do
  scenario "user can see visit about page" do
    #as a user (logged in)

    #when I click link "About"
    visit '/about'

    #I expect my current path to be '/about'
    expect(current_path).to eq(about_path)

    #and I should see "Created by: David Davydov, Nate Anderson, Raphael Barbo, and Brian Heim"
    expect(page).to have_content("Created by: Brian Heim, David Davydov, Nate Anderson, and Raphael Barbo")
  end

  scenario "visitor can see visit about page" do
    #as a visitor (not logged)
    #when I click link "About"
    visit '/about'

    #I expect my current path to be '/about'
    expect(current_path).to eq(about_path)

    #and I should see "Created by: David Davydov, Nate Anderson, Raphael Barbo, and Brian Heim"
    expect(page).to have_content("Created by: Brian Heim, David Davydov, Nate Anderson, and Raphael Barbo")
  end
end
