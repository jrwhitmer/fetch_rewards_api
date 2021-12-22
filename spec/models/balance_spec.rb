require 'rails_helper'
RSpec.describe Balance, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:payer) }
  end
end
