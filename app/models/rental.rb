class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user

  has_many :car_rentals, dependent: :destroy
  has_many :cars, through: :car_rentals

  validates :start_date, :end_date, presence: true

  validate :start_date, :start_date_cannot_be_in_the_past
  validate :end_date, :end_date_cannot_be_less_than_start_date
  validate :available_cars?

  def start_date_cannot_be_in_the_past
    return unless start_date.present? && start_date < Date.current

    errors.add(:start_date, 'está incorreta, não alugamos DeLoreans')
  end

  def end_date_cannot_be_less_than_start_date
    return unless start_date.present? && end_date.present? &&
                  end_date < start_date

    errors.add(:end_date, 'não pode ser antes da Data Inicial')
  end

  def available_cars?
    available_cars = Car.where(status: :disponivel)
                        .joins(:car_model)
                        .where(car_models: { car_category: car_category })
                        .count

    return if available_cars > scheduled

    errors.add(:base, 'Não há carros disponíveis na data pesquisada')
  end

  def scheduled
    Rental.where(car_category: car_category)
          .where(start_date: start_date..end_date)
          .or(Rental.where(car_category: car_category)
          .where(end_date: start_date..end_date))
          .count
  end
end
