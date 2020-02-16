class Car < ApplicationRecord
  enum status: {disponivel: 0, alugado: 5, manutenção:10}, _prefix: :status
  belongs_to :car_model

  def full_description
    "#{car_model.manufacturer.name} #{car_model.name} - #{color}"
  end
end
