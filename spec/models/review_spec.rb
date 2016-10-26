require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'validations' do
    it { should validate_presence_of :subject }
    it { should validate_presence_of :body }
  end
end
