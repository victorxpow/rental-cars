class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category

  validates :name, presence: true, uniqueness: true
  validates :year, presence: true, numericality: { greater_than: 2013 }
  validates :motorization, :fuel_type, presence: true
end
