class CarsController < ApplicationController
    def index
        @cars = Car.all
    end

    def show
        @car = Car.find(params[:id])
    end

    def new
        @car_models = CarModel.all
        @car = Car.new
    end

    def edit
        @car_models = CarModel.all
        @car = Car.find(params[:id])
    end

    def create
        @car = Car.new(car_params) 
        return redirect_to @car, notice: t('.success') if @car.save

        @car_models = CarModel.all
        render :new
    end

    def update
        @car = Car.find(params[:id])
        return redirect_to @car, notice: t('.success') if @car.update(car_params)

        @car_models = CarModel.all
        render :edit
    end

    def destroy
        @car = Car.find(params[:id])
        return redirect_to cars_path, notice: t('.success') if @car.destroy

        render :show
    end

    private

    def car_params
        params.require(:car).permit(:car_model_id, :license_plate, :mileage, :color)        
    end
end