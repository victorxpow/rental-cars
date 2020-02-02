require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar Filial'

    fill_in 'Nome', with: 'Paraíso'
    fill_in 'CNPJ', with: '00.000.000/0000-01'
    fill_in 'Endereço', with: 'Avenue Paraíso'

    click_on 'Criar Filial'

    expect(page).to have_content('Paraíso')
    expect(page).to have_content('00.000.000/0000-01')
    expect(page).to have_content('Avenue Paraíso')
  end

  scenario 'and fields must be filled' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar Filial'
    click_on 'Criar Filial'

    expect(page).to have_content('Você deve corrigir o(s) seguinte(s) erro(s)')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  scenario 'and must be unique' do
    create(:subsidiary)
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar Filial'

    fill_in 'Nome', with: 'Saúde'
    fill_in 'CNPJ', with: '00.000.000/0000-01'
    fill_in 'Endereço', with: 'Avenue Paraíso'

    click_on 'Criar Filial'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'field CNPJ must be valid' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar Filial'

    fill_in 'Nome', with: 'Paraíso'
    fill_in 'CNPJ', with: '00000000000'

    click_on 'Criar Filial'

    expect(page).to have_content('CNPJ não possui o tamanho esperado (18 caracteres)')
  end

  scenario 'and must be authenticated to register' do
    visit new_subsidiary_path

    expect(current_path).to eq(new_user_session_path)
  end
end
