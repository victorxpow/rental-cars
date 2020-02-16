require 'rails_helper'

feature 'User search rental' do
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
    expect(page).to have_css('h1', text: 'Locações')
    expect(page).to have_content('Código')
    expect(page).to have_content('VKN0001')
    expect(page).to have_content('Data de início')
    expect(page).to have_content(Date.current.strftime('%d/%m/%Y'))
    expect(page).to have_content('Data de Retorno')
    expect(page).to have_content(2.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content('Cliente')
    expect(page).to have_content(client.name)
    expect(page).to have_content('Categoria do carro')
    expect(page).to have_content(car_category.name)
  end

  scenario 'with a partial code' do
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
    create(:car, license_plate: 'DEF5678', color: 'Azul', car_model: car_model,
                  mileage: 10_000, status: 0)
    rental = create(:rental, code: 'VKN0001', start_date: Date.current, end_date: 2.day.from_now,
                  client: client, car_category: car_category, user: user)

    other_rental = create(:rental, code: 'VKN0002', start_date: Date.current, end_date: 1.day.from_now,
                   client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)

    visit rentals_path

    fill_in 'Pesquisar', with: 'VKN'
    click_on 'Buscar'

    expect(page).to have_content('VKN0001')
    expect(page).to have_content('VKN0002')
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_link('Locações')
  end

  scenario 'and must be authenticated via route' do
    visit rentals_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to view details' do
    visit rental_path(0o00000)

    expect(current_path).to eq(new_user_session_path)
  end
end
