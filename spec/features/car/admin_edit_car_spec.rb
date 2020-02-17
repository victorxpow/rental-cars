require 'rails_helper'

feature 'Admin edit Car' do
  scenario 'successfully' do
    user = create(:user)
    car = create(:car)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    within("tr#car-#{car.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'

    fill_in 'Placa', with: 'ABC1234'
    fill_in 'Cor', with: 'Branco'
    fill_in 'Quilometrágem', with: '123456'
    select 'Kwid', from: 'Modelo do carro'
    click_on 'Salvar'

    expect(page).to have_content('Carro atualizado com sucesso')
    expect(page).to have_content('ABC1234')
    expect(page).to have_content('Branco')
    expect(page).to have_content('123456')
  end

  scenario 'must fill all fields' do
    user = create(:user)
    car = create(:car)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    within("tr#car-#{car.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'

    fill_in 'Placa', with: ''
    fill_in 'Cor', with: ''
    fill_in 'Quilometrágem', with: ''
    select 'Kwid', from: 'Modelo do carro'
    click_on 'Salvar'

    expect(page).to have_content('Placa do Carro não pode ficar em branco')
    expect(page).to have_content('Cor do Carro não pode ficar em branco')
    expect(page).to have_content('Quilometrágem não pode ficar em branco')
  end

  scenario 'and must be authenticated to edit' do
    visit edit_car_category_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
