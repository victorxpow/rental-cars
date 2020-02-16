require 'rails_helper'

feature 'User schedule rental' do
  scenario 'sucessfully' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category, name: 'LM', daily_rate: 46.54, car_insurance: 28,
                                        third_party_insurance: 10)
    car_model = create(:car_model, name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                  motorization: '1.0', car_category: car_category,
                                  fuel_type: 'Flex')
    client = create(:client)
    car = create(:car, license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                mileage: 10.000, status: 0)

    login_as(user, user: :scope)
    visit root_path
    click_on 'Locações'
    click_on 'Registrar Novo'

    fill_in 'Data de início', with: Date.current
    fill_in 'Data de Retorno', with: 1.day.from_now
    select "#{client.cpf} - #{client.name}", from: 'Cliente'
    select 'LM', from: 'Categoria do carro'
    click_on 'Salvar'

    expect(page).to have_content(Date.current.strftime('%d/%m/%Y'))
    expect(page).to have_content(1.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content('Cliente')
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
  end

  scenario 'must fill all fields' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category, name: 'LM', daily_rate: 46.54, car_insurance: 28,
                                        third_party_insurance: 10)
    car_model = create(:car_model, name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                  motorization: '1.0', car_category: car_category,
                                  fuel_type: 'Flex')
    client = create(:client)
    car = create(:car, license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                mileage: 10.000, status: 0)

    login_as(user, user: :scope)
    visit root_path
    click_on 'Locações'
    click_on 'Registrar Novo'

    fill_in 'Data de início', with: ''
    fill_in 'Data de Retorno', with: ''
    select "#{client.cpf} - #{client.name}", from: 'Cliente'
    select 'LM', from: 'Categoria do carro'
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'and must be authenticated to register' do
    visit new_rental_path

    expect(current_path).to eq(new_user_session_path)
  end
end
