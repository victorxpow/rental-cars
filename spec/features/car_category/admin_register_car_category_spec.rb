require 'rails_helper'

feature 'Admin register Car Category' do
  scenario 'sucessfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'Registrar Novo'

    fill_in 'Nome', with: 'Sedã'
    fill_in 'Diária', with: 30
    fill_in 'Seguro do automóvel', with: 300
    fill_in 'Seguro para Terceiros', with: 250

    click_on 'Salvar'

    expect(page).to have_content('Sedã')
    expect(page).to have_content(30)
    expect(page).to have_content(300)
    expect(page).to have_content(250)
  end

  scenario 'and fields must be filled' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path

    click_on 'Categorias de carro'
    click_on 'Registrar Novo'

    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Diária não pode ficar em branco')
    expect(page).to have_content('Seguro do automóvel não pode ficar em branco')
    expect(page).to have_content('Seguro para Terceiros não pode ficar em branco')
  end

  scenario 'and daily rate, car insurance, third party insurance must be greater than 0' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path

    click_on 'Categorias de carro'
    click_on 'Registrar Novo'

    fill_in 'Nome', with: 'Sedã'
    fill_in 'Diária', with: -1
    fill_in 'Seguro do automóvel', with: -1
    fill_in 'Seguro para Terceiros', with: -1
    click_on 'Salvar'

    expect(page).to have_content('Diária deve ser maior que 0')
    expect(page).to have_content('Seguro do automóvel deve ser maior que 0')
    expect(page).to have_content('Seguro para Terceiros deve ser maior que 0')
  end

  scenario 'and must be authenticated to register' do
    visit new_car_category_path

    expect(current_path).to eq(new_user_session_path)
  end
end
