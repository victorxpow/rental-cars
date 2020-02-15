require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar Novo'

    fill_in 'Nome', with: 'Conceição'
    fill_in 'CNPJ', with: '00.000.000/0000-01'
    fill_in 'Endereço', with: 'Avenida Conceição'

    click_on 'Salvar'

    expect(page).to have_content('Conceição')
    expect(page).to have_content('00.000.000/0000-01')
    expect(page).to have_content('Avenida Conceição')
  end

  scenario 'and fields must be filled' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar Novo'
    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  scenario 'and must be unique' do
    create(:subsidiary)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar Novo'

    fill_in 'Nome', with: 'Saúde'
    fill_in 'CNPJ', with: '00.000.000/0000-01'
    fill_in 'Endereço', with: 'Avenida Conceição'

    click_on 'Salvar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'field CNPJ must be valid' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar Novo'

    fill_in 'Nome', with: 'Conceição'
    fill_in 'CNPJ', with: '00000000000'

    click_on 'Salvar'

    expect(page).to have_content('CNPJ não possui o ' \
      'tamanho esperado (18 caracteres)')
  end

  scenario 'and must be authenticated to register' do
    visit new_subsidiary_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_link('Filiais')
  end
end
