require 'rails_helper'

feature 'Admin edit subsidiary' do
  scenario 'successfully' do
    user = create(:user)
    subsidiary = create(:subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    within("tr#subsidiary-#{subsidiary.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'

    fill_in 'Nome', with: 'Conceição'
    fill_in 'CNPJ', with: '00.000.000/0000-01'
    fill_in 'Endereço', with: 'Avenida Conceição'

    click_on 'Salvar'

    expect(page).to have_content('Conceição')
    expect(page).to have_content('00.000.000/0000-01')
    expect(page).to have_content('Avenida Conceição')
  end

  scenario 'and must fill all fields' do
    user = create(:user)
    subsidiary = create(:subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    within("tr#subsidiary-#{subsidiary.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''

    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  scenario 'and must be authenticate to edit' do
    visit edit_subsidiary_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
