require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar Novo'
    fill_in 'Nome', with: 'Fiat'
    click_on 'Salvar'

    expect(page).to have_content('Fiat')
  end

  scenario 'and must be unique' do
    user = create(:user)
    create(:manufacturer)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar Novo'
    fill_in 'Nome', with: 'Fiat'
    click_on 'Salvar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and fields must be filled' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar Novo'

    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_link('Fabricantes')
  end

  scenario 'and must be authenticated via route' do
    visit new_manufacturer_path

    expect(current_path).to eq(new_user_session_path)
  end
end
