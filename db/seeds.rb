# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Manufacturer.create!([
    { name: 'Volkswagen' },
    { name: 'Fiat' },
    { name: 'Chevrolet' }
])

CarCategory.create!([
    { name: 'A', daily_rate: 100.0, car_insurance: 50.0, third_party_insurance: 25.0 },
    { name: 'B', daily_rate: 110.0, car_insurance: 60.0, third_party_insurance: 30.0 }
])

CarModel.create!([
    { name: 'Gol', year: '2001', motorization: '1.8', fuel_type: 'Gasolina', manufacturer_id: 1, car_category_id: 1 },
    { name: 'Uno', year: '2020', motorization: '1.0', fuel_type: 'Flex', manufacturer_id: 2, car_category_id: 2 },
    { name: 'Onix', year: '2019', motorization: '1.6', fuel_type: 'Flex', manufacturer_id: 3, car_category_id: 1 }
])

Subsidiary.create!([
    { name: 'Santo André', cnpj: '11.222.333/0000-99', address: 'Av. D. Pedro II, 100' },
    { name: 'Osasco', cnpj: '22.333.444/0000-88', address: 'Av. D. Pedro II, 100' }
])

User.create!([
    { email: 'joao@email.com', password: '123456' },
    { email: 'maria@email.com', password: '123456' }
])

Client.create!([
    { name: 'José da Silva', cpf: '111.222.333-44', email: 'jose.silva@email.com' },
    { name: 'Júlia de Souza', cpf: '222.333.444-55', email: 'julia.souza@email.com' }
])

Rental.create!([
    { code: 'JPR0000', start_date: Date.current, end_date: 1.day.from_now, client_id: 1, car_category_id: 1 },
    { code: 'LAR1111', start_date: Date.current, end_date: 2.day.from_now, client_id: 1, car_category_id: 2 },
    { code: 'SAM0000', start_date: Date.current, end_date: 3.day.from_now, client_id: 2, car_category_id: 2 },
])
