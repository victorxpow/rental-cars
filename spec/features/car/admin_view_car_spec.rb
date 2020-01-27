require 'rails_helper'

feature 'Admin view cars' do
    scenario 'successfully' do
        car = FactoryBot.create(:car)
        user = User.create!(email: 'teste@teste.com', password: '123456')


        login_as(user, scope: :user)
        visit root_path
        click_on 'Carros'
        click_on 'Kwid'

        expect(page).to have_content(car.license_plate)
        expect(page).to have_content(car.car_model.name)
        expect(page).to have_content(car.mileage)
        expect(page).to have_content(car.color)
        expect(page).to have_content(car.license_plate)
        expect(page).to have_content(10000)

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
        visit car_path(00000)

        expect(current_path).to eq(new_user_session_path)
    end
end