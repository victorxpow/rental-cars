class ManufacturersController < ApplicationController
    before_action :authenticate_user!, only:[:index,:show,:new, :edit]
    def index
        @manufacturers = Manufacturer.all
    end

    def show
        @manufacturer = Manufacturer.find(params[:id]) 
    end

    def new
        @manufacturer = Manufacturer.new
    end

    def edit
        @manufacturer = Manufacturer.find(params[:id])
    end

    def create
        @manufacturer = Manufacturer.new(manufacturer_params) 

        if @manufacturer.save
            redirect_to @manufacturer
        else
            render :new
        end
    end

    def update
        @manufacturer = Manufacturer.find(params[:id])
        
        if @manufacturer.update(manufacturer_params)
            redirect_to @manufacturer
        else
            render :edit
        end

    end

    def destroy
        @manufacturer = Manufacturer.find(params[:id])
        if @manufacturer.destroy
            flash[:alert] = "Fabricante excluído com sucesso"
            redirect_to manufacturers_path
        else
            redirect_to :show
        end
    end

    private

    def manufacturer_params
        params.require(:manufacturer).permit(:name)
    end
end