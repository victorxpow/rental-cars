class Api::V1::CarsController < Api::V1::ApiController
    def show
        @car = Car.find(params[:id])
        render json: @car
    end

    def index
        @cars = Car.all
        render json: @cars
    end
    
    def create
        @car = Car.new(car_params)
        @car.save
        render json: @car, status: :created
    end

    private

    def car_params
        params.permit(:car_model_id, :license_plate, :mileage, :color)        
    end
end