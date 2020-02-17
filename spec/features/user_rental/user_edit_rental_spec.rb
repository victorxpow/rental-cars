require 'rails_helper'

feature 'user edit rental' do
  scenario 'sucessfully' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category, name: 'AM', daily_rate: 46.54,
                                         car_insurance: 28,
                                         third_party_insurance: 10)
    another_car_category = create(:car_category, name: 'A',
                                                 daily_rate: 46.54,
                                                 car_insurance: 28,
                                                 third_party_insurance: 10)
    car_model = create(:car_model, name: 'Kwid', year: '2020',
                                   manufacturer: manufacturer,
                                   motorization: '1.0',
                                   car_category: car_category,
                                   fuel_type: 'Flex')
    another_car_model = create(:car_model, name: 'Sandero', year: '2019',
                                           manufacturer: manufacturer,
                                           motorization: '1.6',
                                           car_category: another_car_category,
                                           fuel_type: 'Flex')
    client = create(:client)
    other_client = create(:client, name: 'José', cpf: '123.456.789-45',
                                   email: 'teste@jose.com')
    create(:car, license_plate: 'ABC1234', color: 'Branco',
                 car_model: car_model,
                 mileage: 10_000, status: 0)
    create(:car, license_plate: 'DEF5678', color: 'Azul',
                 car_model: another_car_model,
                 mileage: 10_000, status: 0)
    rental = create(:rental, code: 'VKN0001', start_date: Date.current,
                             end_date: 2.days.from_now,
                             client: client, car_category: car_category,
                             user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    within("tr#rental-#{rental.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'
    fill_in 'Data de início', with: Date.current
    fill_in 'Data de Retorno', with: 3.days.from_now
    select "#{other_client.cpf} - #{other_client.name}", from: 'Cliente'
    select 'A', from: 'Categoria do carro'
    click_on 'Salvar'

    expect(page).to have_content('Locação atualizada com sucesso')
    expect(page).to have_content(Date.current.strftime('%d/%m/%Y'))
    expect(page).to have_content(3.days.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content(other_client.name)
    expect(page).to have_content(other_client.cpf)
  end

  scenario 'and must fill all field' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category, name: 'AM', daily_rate: 46.54,
                                         car_insurance: 28,
                                         third_party_insurance: 10)
    another_car_category = create(:car_category, name: 'A',
                                                 daily_rate: 46.54,
                                                 car_insurance: 28,
                                                 third_party_insurance: 10)
    car_model = create(:car_model, name: 'Kwid', year: '2020',
                                   manufacturer: manufacturer,
                                   motorization: '1.0',
                                   car_category: car_category,
                                   fuel_type: 'Flex')
    another_car_model = create(:car_model, name: 'Sandero', year: '2019',
                                           manufacturer: manufacturer,
                                           motorization: '1.6',
                                           car_category: another_car_category,
                                           fuel_type: 'Flex')
    client = create(:client)
    other_client = create(:client, name: 'José', cpf: '123.456.789-45',
                                   email: 'teste@jose.com')
    create(:car, license_plate: 'ABC1234', color: 'Branco',
                 car_model: car_model,
                 mileage: 10_000, status: 0)
    create(:car, license_plate: 'DEF5678', color: 'Azul',
                 car_model: another_car_model,
                 mileage: 10_000, status: 0)
    rental = create(:rental, code: 'VKN0001', start_date: Date.current,
                             end_date: 2.days.from_now,
                             client: client, car_category: car_category,
                             user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    within("tr#rental-#{rental.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'
    fill_in 'Data de início', with: ''
    fill_in 'Data de Retorno', with: ''
    select "#{other_client.cpf} - #{other_client.name}", from: 'Cliente'
    select 'A', from: 'Categoria do carro'
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco')
  end
end
