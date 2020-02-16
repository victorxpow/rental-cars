require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#identification' do
    it 'should create a basic identification' do
      client = Client.create!(name: 'José da Silva', cpf: '123.456.789-10',
                              email: 'jose@teste.com')
      result = client.identification

      expect(result).to eq '123.456.789-10 - José da Silva'
    end
  end
end
