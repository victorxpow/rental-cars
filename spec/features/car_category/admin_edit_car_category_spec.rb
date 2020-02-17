require 'rails_helper'

feature 'Admin edit Car Category' do
  scenario 'successfully' do
    user = create(:user)
    car_category = create(:car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    within("tr#car_category-#{car_category.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'

    fill_in 'Nome', with: 'SUV compacto'
    click_on 'Salvar'

    expect(page).to have_content('Categoria de carro atualizado com sucesso')
    expect(page).to have_content('SUV compacto')
  end

  scenario 'and fields must be filled' do
    user = create(:user)
    car_category = create(:car_category)

    login_as(user, scope: :user)
    visit root_path

    click_on 'Categorias de carro'
    within("tr#car_category-#{car_category.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro do automóvel', with: ''
    fill_in 'Seguro para Terceiros', with: ''

    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Diária não pode ficar em branco')
    expect(page).to have_content('Seguro do automóvel não pode ficar em branco')
    expect(page).to have_content('Seguro para Terceiros não pode ficar em branco')
  end

  scenario 'and must be authenticated to edit' do
    visit edit_car_category_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
