class CarModelsController < ApplicationController
    before_action :set_car_model, only:[:show,:edit,:update]

    def index
        @car_models = CarModel.all
    end

    def show
    end

    def new
        @car_model = CarModel.new
        load_manufacturer_and_car_categories
    end

    def edit
        load_manufacturer_and_car_categories
    end

    def create
        @car_model = CarModel.new(car_model_params)

        return redirect_to @car_model, 
                notice: 'Registrado com sucesso' if @car_model.save

                load_manufacturer_and_car_categories
        render :new
    end
    
    def update
        return redirect_to @car_model,
                notice: 'Editado com sucesso' if @car_model.update(car_model_params)
        
                load_manufacturer_and_car_categories
        render :edit
    end

    private

    def set_car_model
        @car_model = CarModel.find(params[:id])
    end

    def load_manufacturer_and_car_categories
        @manufacturers = Manufacturer.all
        @car_categories = CarCategory.all
    end

    def car_model_params
        params.require(:car_model).permit(:name,:year,:manufacturer_id,:motorization,
                                            :car_category_id,:fuel_type)
    end
end
