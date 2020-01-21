require 'rails_helper'

describe 'Car Menagement' do
  context 'show' do
    it 'renders a json succssfully' do
      Manufacturer.create!(name: 'Chevrolet')
      subsidiary = Subsidiary.create!(name: 'aAldddmesidinha Trucks', cnpj: '11.200.000/0000-00',
          address: 'Aldameda Sdddanstos, 1293')
      car_category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      car_model = CarModel.create!(name: 'Onix', year: '2019', motorization: '1.6',
        fuel_type: 'Flex', manufacturer_id: 1, car_category_id: 1)
      car = Car.create!(license_plate: 'CGQ 2866', color: 'vermelho', car_model: car_model, mileage: 155, status: 0)

      get api_v1_car_path(car)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      #expect(json[:name]).to eq(car.car_model.name)
      expect(json[:license_plate]).to eq(car.license_plate)
      expect(json[:color]).to eq(car.color)
      expect(json[:mileage]).to eq(car.mileage)
      expect(json[:status]).to eq(car.status)



    end
  end
end
