require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path

    click_on 'Clientes'
    click_on 'Registrar Novo'
    fill_in 'Nome', with: 'Victor'
    fill_in 'CPF', with: '452.183.937.31'
    fill_in 'Email', with: 'teste@gmail.com'
    click_on 'Salvar'

    expect(page).to have_content('Victor')
    expect(page).to have_content('452.183.937.31')
    expect(page).to have_content('teste@gmail.com')
  end

  scenario 'and must fill all fields' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path

    click_on 'Clientes'
    click_on 'Registrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
  end

  scenario 'and email must be valid' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path

    click_on 'Clientes'
    click_on 'Registrar Novo'
    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '452.183.937.31'
    fill_in 'Email', with: 'dsadas'
    click_on 'Salvar'

    expect(page).to have_content('Email não é válido')
  end

  scenario 'and must be authenticated via route' do
    visit new_client_path

    expect(current_path).to eq(new_user_session_path)
  end
end
