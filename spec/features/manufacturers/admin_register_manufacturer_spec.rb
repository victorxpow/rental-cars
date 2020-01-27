require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar fabricante'
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
  end

  scenario 'and must be unique' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    FactoryBot.create(:manufacturer)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar fabricante'
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fornecedor já cadastrado')
  end

  scenario 'and fields must be filled' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar fabricante'

    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar vazio')
  end

  scenario 'and must be authenticated to register' do
    visit new_manufacturer_path

    expect(current_path).to eq(new_user_session_path)
  end
end