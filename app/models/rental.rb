class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       

  has_many :car_rentals
  has_many :cars, through: :car_rentals

  def date_init_less_than_final
  end  
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       