require 'rails_helper'

RSpec.feature "Visitor cannot visit dashboard pages" do
  scenario "visitor cannot see dashboard page" do
    #As a visitor
    #when I click on "/dashboard"
    visit '/dashboard'
    #I expect to see a 404 Error page
    expect(page.status_code).to eq(404)
  end

  scenario "visitor cannot edit profile on dashboard page" do
    #As a visitor
    #when I click on "/dashboard/randomID/edit"
    visit 'dashboard/1/edit'
    #I expect to see a 404 Error page
    expect(page.status_code).to eq(404)
  end
end
