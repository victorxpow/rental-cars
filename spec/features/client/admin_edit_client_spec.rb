require 'rails_helper'

feature 'Admin edit client' do
  scenario 'successfully' do
    user = create(:user)
    client = create(:client)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    within("tr#client-#{client.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'

    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '452.183.937.31'
    fill_in 'Email', with: 'dsadas@fdssa.com'
    click_on 'Salvar'

    expect(page).to have_content('João')
    expect(page).to have_content('452.183.937.31')
    expect(page).to have_content('dsadas@fdssa.com')
  end

  scenario 'and must fill all fields' do
    user = create(:user)
    client = create(:client)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    within("tr#client-#{client.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
  end

  scenario 'and must be authenticated to edit' do
    visit edit_client_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
