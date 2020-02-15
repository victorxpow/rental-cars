require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'successfully' do
    user = create(:user)
    car_category = create(:car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    within("tr#car_category-#{car_category.id}") do
      find('.ls-ico-zoomin').click
    end

    expect(page).to have_content(car_category.name)
    expect(page).to have_content(car_category.daily_rate)
    expect(page).to have_content(car_category.car_insurance)
    expect(page).to have_content(car_category.third_party_insurance)
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_button('Categorias de carro')
  end

  scenario 'and must be authenticated via route' do
    visit car_categories_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to view details' do
    visit car_category_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
