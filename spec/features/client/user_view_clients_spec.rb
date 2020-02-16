require 'rails_helper'

feature 'User view client' do
  scenario 'successfully' do
    user = create(:user)
    client = create(:client)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'

    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
    expect(page).to have_content(client.email)
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_button('Clientes')
  end

  scenario 'and must be authenticated via route' do
    visit clients_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to view details' do
    visit client_path(00000)

    expect(current_path).to eq(new_user_session_path)
  end
end