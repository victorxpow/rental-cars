require 'rails_helper'

feature 'Admin register Car Model' do
  scenario 'successfully' do
    user = create(:user)
    create(:manufacturer)
    create(:car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar Novo'

    fill_in 'Nome', with: 'Onix Hatch'
    fill_in 'Ano', with: '2019'
    select 'Fiat', from: 'Fabricante'
    fill_in 'Motorização', with: '1.4'
    select 'AM', from: 'Categoria do carro'
    fill_in 'Tipo de combustível', with: 'Flex'

    click_on 'Salvar'

    expect(page).to have_content('Onix Hatch')
    expect(page).to have_content('2019')
    expect(page).to have_content( 'Fiat')
    expect(page).to have_content( '1.4')
    expect(page).to have_content( 'AM')
    expect(page).to have_content( 'Flex')
  end

  scenario 'car year greather than 2013' do
    user = create(:user)
    create(:manufacturer)
    create(:car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar Novo'

    fill_in 'Nome', with: 'Onix Hatch'
    fill_in 'Ano', with: '2010'
    select 'Fiat', from: 'Fabricante'
    fill_in 'Motorização', with: '1.4'
    select 'AM', from: 'Categoria do carro'
    fill_in 'Tipo de combustível', with: 'Flex'

    click_on 'Salvar'

    expect(page).to have_content('Ano deve ser maior que 2013')
  end

  scenario 'and must fill all fields' do
    user = create(:user)
    create(:manufacturer)
    create(:car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar Novo'

    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Motorização não pode ficar em branco')
    expect(page).to have_content('Tipo de combustível não pode ficar em branco')
  end

  scenario 'and must be authenticated to register' do
    visit new_car_model_path

    expect(current_path).to eq(new_user_session_path)
  end
end
