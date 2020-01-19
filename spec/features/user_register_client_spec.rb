require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path

    click_on 'Clientes'
    click_on 'Registrar cliente'
    fill_in 'Nome', with: 'Victor'
    fill_in 'CPF', with: '000.000.000-00'
    fill_in 'Email', with: 'teste@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Victor')
    expect(page).to have_content('000.000.000-00')
    expect(page).to have_content('teste@gmail.com')
  end

  scenario 'and must be authenticated via route' do
    visit new_client_path

    expect(current_path).to eq(new_user_session_path)
  end
end