require 'rails_helper'

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_many(:user_roles) }
    it { should have_many(:roles) }
  end

  context 'validations' do
    # it { should validate_length_of(:api_key).is_equal_to(32) }
  end

  it "is an inactive user by default" do
    user = create(:user)
    expect(user.status).to eq('inactive')
  end

  it 'can become an active user' do
    user = create(:user)
    user.activate
    expect(user.status).to eq('active')
  end

  it 'can be a traveler' do
    user = create(:user, status: 'active')
    traveler_role = create(:role, name: 'traveler')
    user.roles << traveler_role
    expect(user.traveler?).to eq(true)
  end

  it 'can be a host' do
    user = create(:user, status: 'active')
    host_role = create(:role, name: 'host')
    user.roles << host_role
    expect(user.host?).to eq(true)
  end

  it 'can be an admin' do
    user = create(:user, status: 'active')
    admin_role = create(:role, name: 'admin')
    user.roles << admin_role
    expect(user.admin?).to eq(true)
  end
end
