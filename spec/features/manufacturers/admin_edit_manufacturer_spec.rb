require 'rails_helper'

feature 'Admin edit manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    manufacturer = create(:manufacturer)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    within("tr#manufacturer-#{manufacturer.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Salvar'

    expect(page).to have_content('Honda')
  end

  scenario 'and must be unique' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    create(:manufacturer)
    other_manufacturer = create(:manufacturer, name: 'Chev')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    within("tr#manufacturer-#{other_manufacturer.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'
    fill_in 'Nome', with: 'Fiat'
    click_on 'Salvar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and fields must be filled' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    manufacturer = create(:manufacturer)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    within("tr#manufacturer-#{manufacturer.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and must be authenticated to edit' do
    visit edit_manufacturer_path(00000)

    expect(current_path).to eq(new_user_session_path)
  end
end