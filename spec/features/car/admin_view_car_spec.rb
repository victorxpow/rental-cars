require 'rails_helper'

feature 'Admin view cars' do
  scenario 'successfully' do
    car = create(:car)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    within("tr#car-#{car.id}") do
      find('.ls-ico-zoomin').click
    end

    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(car.car_model.name)
    expect(page).to have_content(car.mileage)
    expect(page).to have_content(car.color)
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(10_000)
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_button('Carros')
  end

  scenario 'and must be authenticated via route' do
    visit cars_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to view details' do
    visit car_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
