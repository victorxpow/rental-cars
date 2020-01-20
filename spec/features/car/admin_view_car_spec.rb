require 'rails_helper'

feature 'Admin view cars' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        manufacturer = Manufacturer.create!(name: 'Renault')
        car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                           third_party_insurance: 10)
        car_model = CarModel.create!(name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                     motorization: '1.0', car_category: car_category,
                                     fuel_type: 'Flex')
        Car.create!(license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                          mileage: 10000)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Carros'
        click_on 'Kwid'

        expect(page).to have_content('Kwid')
        expect(page).to have_content('ABC1234')
        expect(page).to have_content('Branco')
        expect(page).to have_content('AM')
        expect(page).to have_content(10000)

    end

    scenario 'and must be authenticated via button' do
        visit root_path
        
        expect(page).not_to have_content('Carros')
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