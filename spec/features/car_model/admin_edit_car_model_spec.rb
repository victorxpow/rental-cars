require 'rails_helper'

feature 'Admin edit car model' do
  scenario 'successfully' do
    user = create(:user)
    car_model = create(:car_model)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    within("tr#car_model-#{car_model.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'

    fill_in 'Nome', with: 'Uno'
    fill_in 'Ano', with: '2020'
    select 'Fiat', from: 'Fabricante'
    fill_in 'Motorização', with: '2.0'
    select 'AM', from: 'Categoria do carro'
    fill_in 'Tipo de combustível', with: 'Álcool'
    click_on 'Salvar'

    expect(page).to have_content('Uno')
    expect(page).to have_content('2020')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('2.0')
    expect(page).to have_content('AM')
    expect(page).to have_content('Álcool')
  end

  scenario 'and must fill all fields' do
    user = create(:user)
    car_model = create(:car_model)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    within("tr#car_model-#{car_model.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Ano', with: ''
    select 'Fiat', from: 'Fabricante'
    fill_in 'Motorização', with: ''
    select 'AM', from: 'Categoria do carro'
    fill_in 'Tipo de combustível', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Motorização não pode ficar em branco')
    expect(page).to have_content('Tipo de combustível não pode ficar em branco')
  end

  scenario 'and must be authenticated to edit' do
    visit edit_car_model_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
