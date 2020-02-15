class CarCategoriesController < ApplicationController
  def index
    @car_categories = CarCategory.all
  end

  def show
    @car_category = CarCategory.find(params[:id])
  end

  def new
    @car_category = CarCategory.new
  end

  def create
    @car_category = CarCategory.new(car_category_params)
    return redirect_to @car_category, notice: t('.success') if @car_category.save

    render :new
  end

  def edit
    @car_category = CarCategory.find(params[:id])
  end

  def update
    @car_category = CarCategory.find(params[:id])
    return redirect_to car_categories_path, 
    notice: t('.success') if @car_category.update(car_category_params)

    render :edit
  end

  def destroy
    @car_category = CarCategory.find(params[:id])
    return redirect_to car_categories_path, notice: t('.success') if @car_category.destroy

    render :show
  end

  private

  def car_category_params
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end
end
