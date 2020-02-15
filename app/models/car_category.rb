class CarCategory < ApplicationRecord
    has_many :car_models
    validates :name, presence: true
    validates :daily_rate, :car_insurance, :third_party_insurance, presence: true,
                        numericality: {greater_than: 0}

    def daily_rated
        daily_rate + car_insurance + third_party_insurance
    end
end
