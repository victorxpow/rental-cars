require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    User.create!(email: 'teste@teste.com', password: '123456')

    visit root_path

    within 'form' do
      fill_in 'Email', with: 'teste@teste.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_link('Sair')
    expect(page).not_to have_button('Entrar')
    expect(current_path).to eq(root_path)
  end

  scenario 'and sign out successfully' do
    User.create!(email: 'teste@teste.com', password: '123456')

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