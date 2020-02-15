require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    create(:user)

    visit root_path

    within 'form' do
      fill_in 'Email', with: 'teste@teste.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_link('Sair')
    expect(page).not_to have_button('Entrar')
    expect(current_path).to eq(root_path)
  end

  scenario 'and sign out successfully' do
    create(:user)

    visit root_path

    within 'form' do
      fill_in 'Email', with: 'teste@teste.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    within 'div#dropdw' do
      click_on 'Sair'
    end
      
      
    expect(page).not_to have_link('Sair')
    expect(page).to have_button('Entrar')
    expect(current_path).to eq(new_user_session_path)
  end
end