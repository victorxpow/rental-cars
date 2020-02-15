require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#nickname' do
    it 'should create a nickname for user' do
      user = build(:user)
      result = user.nickname

      expect(result).to eq user.nickname
    end
  end
end
