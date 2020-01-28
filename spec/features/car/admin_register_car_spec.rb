require 'rails_helper'

feature 'Admin register Car' do
    scenario 'sucessfully' do
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
        click_on 'Cadastrar carro'

        fill_in 'Placa', with: 'ABC1234'
        fill_in 'Cor', with: 'Branco'
        fill_in 'Quilometragem', with: '10000'
        select "Kwid", from: 'Nome do modelo'

        click_on 'Enviar'
        
        expect(page).to have_content('ABC1234')
        expect(page).to have_content('Branco')
        expect(page).to have_content('Kwid')
        expect(page).to have_content(10000)

    end

    scenario 'and fields must be filled' do
        
    end

    scenario 'and must be greater than 0' do
      
    end

    scenario 'and must be authenticated to register' do
        visit new_car_path

        expect(current_path).to eq(new_user_session_path)
    end
end