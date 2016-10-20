require 'rails_helper'

RSpec.describe Role, type: :model do
  context "associations" do
    it { should have_many(:users) }
    it { should have_many(:user_roles) }
  end
end
