require 'rails_helper'

RSpec.feature "Visitor cannot visit dashboard pages" do
  scenario "visitor cannot see dashboard page" do
    visit '/dashboard'
    expect(page.status_code).to eq(404)
  end

  scenario "visitor cannot edit profile on dashboard page" do
    visit 'dashboard/1/edit'
    expect(page.status_code).to eq(404)
  end
end
