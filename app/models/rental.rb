class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       

  has_many :car_rentals
  has_many :cars, through: :car_rentals


  validate :date_init_less_than_final, on: [:new, :create]
  validate :expiration_date_cannot_be_in_the_past, on: [:new, :create]

  def date_init_less_than_final
    if start_date.present? && start_date > end_date 
      errors.add(:start_date, "End date must be after initial date.")
    end
  end  

  def expiration_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end
end

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       