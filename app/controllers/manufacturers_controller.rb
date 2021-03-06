class ManufacturersController < ApplicationController
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
    return redirect_to @manufacturer,
    notice: t('.success') if @manufacturer.save

    render :new
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    return redirect_to @manufacturer,
    notice: t('.success') if @manufacturer.update(manufacturer_params)

    render :edit
  end

  def destroy
    @manufacturer = Manufacturer.find(params[:id])
    return redirect_to manufacturers_path,
    notice: t('.success') if @manufacturer.destroy

    redirect_to :show
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end
