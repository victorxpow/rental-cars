require 'rails_helper'

describe 'Car Menagement' do
  context 'show' do
    it 'renders a json succssfully' do
      manufacturer = Manufacturer.create!(name: 'Chevrolet')
      car_category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      car_model = CarModel.create!(name: 'Onix', year: '2019', motorization: '1.6',
        fuel_type: 'Flex', manufacturer: manufacturer, car_category: car_category)
      car = Car.create!(license_plate: 'CGQ 2866', color: 'vermelho', car_model: car_model, mileage: 10, status: 0)

      get api_v1_car_path(car)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      #expect(json[:name]).to eq(car.car_model.name)
      expect(json[:license_plate]).to eq(car.license_plate)
      expect(json[:color]).to eq(car.color)
      expect(json[:mileage]).to eq(car.mileage.to_s)
      expect(json[:status]).to eq(car.status)
    end
  end
    context 'index' do
      it 'renders a json succssfully' do
        Manufacturer.create!(name: 'Chevrolet')
        car_category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
        car_model = CarModel.create!(name: 'Onix', year: '2019', motorization: '1.6',
                                     fuel_type: 'Flex', manufacturer_id: 1, car_category_id: 1)
        other_car_model = CarModel.create!(name: 'Celta', year: '2017', motorization: '1.0',
                                           fuel_type: 'Gasolina', manufacturer_id: 1, car_category_id: 1)
        other_car = Car.create!(license_plate: 'CGQ 2866', color: 'vermelho', car_model: car_model, mileage: 155, status: 0)
        another_car = Car.create!(license_plate: 'ABC 1266', color: 'prata', car_model: other_car_model, mileage: 15, status: 0)
        car = Car.create!(license_plate: 'DFE 1234', color: 'branco', car_model: car_model, mileage: 298, status: 0)
  
        get api_v1_cars_path()
        json = JSON.parse(response.body, symbolize_names: true)
  
        expect(response).to have_http_status(200)
        expect(json.length). to eq 3
        expect(json[0][:license_plate]).to include other_car.license_plate
        expect(json[0][:color]).to include other_car.color
        expect(json[0][:mileage]).to eq (other_car.mileage.to_s)
        expect(json[0][:status]).to include other_car.status
  
        expect(json[1][:license_plate]).to include another_car.license_plate
        expect(json[1][:color]).to include another_car.color
        expect(json[1][:mileage]).to eq (another_car.mileage.to_s)
        expect(json[1][:status]).to include another_car.status
  
        expect(json[2][:license_plate]).to include car.license_plate
        expect(json[2][:color]).to include car.color
        expect(json[2][:mileage]).to eq (car.mileage.to_s)
        expect(json[2][:status]).to include car.status
  
      end
    end
  
    context 'create' do
      it 'should return rendered car successfully' do
        
        manufacturer = Manufacturer.create!(name: 'Fabricante A')
        car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
                                        third_party_insurance: '100.65')
        car_model = CarModel.create!(name: 'Fox', year: '1992', manufacturer: manufacturer, motorization: '2000', 
                                      car_category: car_category, fuel_type: 'Gasolina')
        car = Car.create!(license_plate: 'DFE 1234', color: 'branco', car_model: car_model, mileage: 298, status: 0)
  
        post api_v1_cars_path, params: {  car_model_id: car_model.id,
                                          license_plate: car.license_plate,
                                          mileage: car.mileage,
                                          color: car.color
                                        }
  
        json = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to have_http_status(201)
        expect(json[:car_model_id]).to eq(car_model.id)
        expect(json[:license_plate]).to eq(car.license_plate)
        expect(json[:mileage]).to eq(car.mileage.to_s)
        expect(json[:color]).to eq(car.color)
  
      end
    end
  end
  
  