require 'rails_helper'

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_many(:user_roles) }
    it { should have_many(:roles) }
  end

  
end
