require 'rails_helper'

feature 'Admin delete client' do
  scenario 'successfully' do
    user = create(:user)
    client = create(:client)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    within("tr#client-#{client.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Deletar'
    
    expect(page).to have_content('Cliente deletado com sucesso')
    expect(page).to_not have_content(client)
    expect(page).to_not have_content(client.name)
  end
  scenario 'and must be authenticated to delete' do
    visit car_model_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
