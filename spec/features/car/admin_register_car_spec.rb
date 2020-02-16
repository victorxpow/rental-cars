require 'rails_helper'

feature 'Admin register Car' do
  scenario 'sucessfully' do
    user = create(:user)
    car_model = create(:car_model)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Registrar Novo'

    fill_in 'Placa', with: 'ABC1234'
    fill_in 'Cor', with: 'Branco'
    fill_in 'Quilometrágem', with: '10000'
    select 'Kwid', from: 'Modelo do carro'

    click_on 'Salvar'

    expect(page).to have_content('ABC1234')
    expect(page).to have_content('Branco')
    expect(page).to have_content('Kwid')
    expect(page).to have_content(10_000)
  end

  scenario 'and fields must be filled' do
    user = create(:user)
    car_model = create(:car_model)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Registrar Novo'

    fill_in 'Placa', with: ''
    fill_in 'Cor', with: ''
    fill_in 'Quilometrágem', with: ''
    select 'Kwid', from: 'Modelo do carro'

    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'and must be greater than 0' do
    user = create(:user)
    car_model = create(:car_model)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Registrar Novo'

    fill_in 'Placa', with: 'ABC1234'
    fill_in 'Cor', with: 'Branco'
    fill_in 'Quilometrágem', with: '-1'
    select 'Kwid', from: 'Modelo do carro'

    click_on 'Salvar'

    expect(page).to have_content('Quilometrágem deve ser maior que 0')
    expect(page).to_not have_content('ABC1234')
    expect(current_path).to eq(cars_path)
  end

  scenario 'and plate must be uniq' do
    user = create(:user)
    car = create(:car, license_plate: 'JID1234')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Registrar Novo'

    fill_in 'Placa', with: 'JID1234'
    fill_in 'Cor', with: 'Branco'
    fill_in 'Quilometrágem', with: '10000'
    select 'Kwid', from: 'Modelo do carro'

    click_on 'Salvar'

    expect(page).to have_content('Placa do Carro já está em uso')
  end

  scenario 'and must be authenticated to register' do
    visit new_car_path

    expect(current_path).to eq(new_user_session_path)
  end
end
