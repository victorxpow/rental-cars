FactoryBot.define do
  factory :car do
    license_plate { 'ABC1234' }
    color { 'Branco' }
    mileage { 10_000 }
    status { 0 }
    car_model
  end
end
