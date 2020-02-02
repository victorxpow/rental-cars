class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, uniqueness: true, presence: true
  validates :cnpj, length: { is: 18 }, format:
  { with: %r{[0-9.&/-]*}, message: 'Apenas números no CNPJ' }
end
