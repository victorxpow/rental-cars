require 'rails_helper'

feature 'User begin rental' do
  scenario 'and view all avaliable cars before' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category, name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                        third_party_insurance: 10)
    another_car_category = create(:car_category, name: 'A', daily_rate: 46.54, car_insurance: 28,
                                                third_party_insurance: 10)
    car_model = create(:car_model, name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                  motorization: '1.0', car_category: car_category,
                                  fuel_type: 'Flex')
    another_car_model = create(:car_model, name: 'Sandero', year: '2019', manufacturer: manufacturer,
                                          motorization: '1.6', car_category: another_car_category,
                                          fuel_type: 'Flex')
    client = create(:client)
    car = create(:car, license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                mileage: 10_000, status: 0)
    create(:car, license_plate: 'DEF5678', color: 'Azul', car_model: another_car_model,
                mileage: 10_000, status: 0)
    rental = create(:rental, code: 'VKN0001', start_date: Date.current, end_date: 2.day.from_now,
                  client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    within("tr#rental-#{rental.id}") do
      click_on 'Agendar'
    end

    expect(page).to have_content('Selecionar Carro')
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(car.color)
    expect(page).to have_content(car_model.name)
    expect(page).to have_content(manufacturer.name)
    expect(page).not_to have_content('Renault')
  end

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
    rental = create(:rental, code: 'VKN0001', start_date: Date.current, end_date: 2.day.from_now,
                  client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    within("tr#rental-#{rental.id}") do
      click_on 'Agendar'
    end
    within("tr#car-#{car.id}") do
      click_on 'Confirmar'
    end

    expect(page).to have_content("Locação - Vkn0001")
    expect(page).to have_content('Status: Alugado')
    expect(page).to have_content(Date.current.strftime("%d/%m/%Y"))
    expect(page).to have_content(car.mileage)
    expect(page).to have_content(84.54)
  end

  scenario 'and unavaliable cars must be blocked' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category, name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                        third_party_insurance: 10)
    another_car_category = create(:car_category, name: 'A', daily_rate: 46.54, car_insurance: 28,
                                                third_party_insurance: 10)
    car_model = create(:car_model, name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                  motorization: '1.0', car_category: car_category,
                                  fuel_type: 'Flex')
    another_car_model = create(:car_model, name: 'Sandero', year: '2019', manufacturer: manufacturer,
                                          motorization: '1.6', car_category: another_car_category,
                                          fuel_type: 'Flex')
    client = create(:client)
    car = create(:car, license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                mileage: 10_000, status: 0)
    create(:car, license_plate: 'DEF5678', color: 'Azul', car_model: another_car_model,
                mileage: 10_000, status: 5)
    rental = create(:rental, code: 'VKN0001', start_date: Date.current, end_date: 2.day.from_now,
                  client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    within("tr#rental-#{rental.id}") do
      click_on 'Agendar'
    end

    expect(page).to have_content('ABC1234')
    expect(page).not_to have_content('DEF5678')
  end
end
