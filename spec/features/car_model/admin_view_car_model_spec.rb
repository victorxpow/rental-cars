require 'rails_helper'

feature 'Admin view Car Model' do
  scenario 'successfully' do
    user = create(:user)
    car_model = create(:car_model)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    within("tr#car_model-#{car_model.id}") do
        find('.ls-ico-zoomin').click
      end

    expect(page).to have_content(car_model.name)
    expect(page).to have_content("#{car_model.year}")
    expect(page).to have_content("#{car_model.manufacturer.name}")
    expect(page).to have_content("#{car_model.motorization}")
    expect(page).to have_content("#{car_model.car_category.name}")
    expect(page).to have_content("#{car_model.fuel_type}")
  end
  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_button('Modelos de carro')
  end

  scenario 'and must be authenticated via route' do
    visit car_models_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to view details' do
    visit car_model_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
