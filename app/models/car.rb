class Car < ApplicationRecord
  validates :license_plate, presence: true, uniqueness: true
  validates :mileage, presence: true, numericality: { greater_than: 0 }
  validates :color, :status, presence: true

  enum status: {disponivel: 0, alugado: 5, manutenção:10}, _prefix: :status
  belongs_to :car_model
  


  def full_description
    "#{car_model.manufacturer.name} #{car_model.name} - #{color}"
  end
end
