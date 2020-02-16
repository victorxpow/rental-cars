FactoryBot.define do
  factory :rental do
    code { 'JPR0000' }
    start_date { Date.current }
    end_date { 1.day.from_now }
    client
    car_category
    user
  end
end
