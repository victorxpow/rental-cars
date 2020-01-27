class CarsController < ApplicationController
    def index
        @cars = Car.all
    end

    def show
        @car = Car.find(params[:id])
    end

    def new
        @car = Car.new
    end

    def edit
        @car = Car.find(params[:id])
    end

    def create
        @car = Car.new(car_params) 
        return redirect_to @car if @car.save
        render :new
    end

    def update
        @car = Car.find(params[:id])
        return redirect_to @car if @car.update(car_params)
        render :edit
    end

    def destroy
        @car = Car.find(params[:id])
        return redirect_to cars_path flash[:alert] = "Excluído com sucesso" if @car.destroy
        redirect_to :show
    end

    private

    def car_params
        params.require(:car).permit(:car_model_id, :license_plate, :mileage, :color)        
    end
end