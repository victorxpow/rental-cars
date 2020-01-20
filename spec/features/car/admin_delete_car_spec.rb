require 'rails_helper'

feature 'Admin delete car' do
    scenario 'successfully' do
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
        click_on 'Deletar'

        expect(page).to have_content('Excluído com sucesso')
    end
end