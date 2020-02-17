require 'rails_helper'

feature 'user cancel a schedule' do
  scenario 'successfully' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category, name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                         third_party_insurance: 10)
    car_model = create(:car_model, name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                   motorization: '1.0', car_category: car_category,
                                   fuel_type: 'Flex')
    client = create(:client)
    car = create(:car, license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                       mileage: 10.000, status: 0)
    rental = create(:rental, code: 'VKN0001', start_date: Date.current, end_date: 2.days.from_now,
                             client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    within("tr#rental-#{rental.id}") do
      click_on 'Detalhes'
    end
    click_on 'Cancelar'

    expect(page).to_not have_content(rental)
    expect(page).to have_content('Locação cancelada com sucesso')
  end
end
