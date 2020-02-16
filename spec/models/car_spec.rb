require 'rails_helper'

RSpec.describe Car, type: :model do
  describe '#full_description' do
    it 'should create a full description of car' do
      car = FactoryBot.build(:car)
      result = car.full_description

      expect(result).to eq car.full_description
    end
  end
end
