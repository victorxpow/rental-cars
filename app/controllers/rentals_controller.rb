class RentalsController < ApplicationController
  def index; end

  def new
    @rental = Rental.new
    @clients = Client.all
    @car_category = CarCategory.all
  end

  def search
    @rentals = Rental.where('code LIKE ?', "%#{params[:q].upcase}%")
  end
  
  def create
    @rental = Rental.new(rental_params)
    @rental.code = SecureRandom.hex(6).upcase
    @rental.user = current_user
    return redirect_to @rental, notice: 'Locação agendada com sucesso' if @rental.save
    @clients = Client.all
    @car_category = CarCategory.all
    render :new
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def begin
    @rental = Rental.find(params[:id])
    @cars = Car.where(car_model: @rental.car_category.car_models)
               .where(status: 0)
  end

  def confirm_begin
    @car = Car.find(params[:id])
    @rental = Rental.find(params[:id])
    @car.status_alugado!
    @car_rental = CarRental.create!(rental: @rental, car: @car,
                      daily_rate: @car.car_model.car_category.daily_rated,
                      start_mileage: @car.mileage)
  end

  def edit
    @rental = Rental.find(params[:id])
    load_client_and_category
  end

  def update
    @rental = Rental.find(params[:id])
    return redirect_to @rental,
    notice: t('.success') if @rental.update(rental_params)

    load_client_and_category
    render :edit
  end

  def destroy
    @rental = Rental.find(params[:id])
    return redirect_to rentals_path,
    notice: t('.success') if @rental.destroy

    load_client_and_category
    render :show
  end

  private
  
  def rental_params
    params.require(:rental).permit(:start_date, :end_date, 
                                   :client_id, :car_category_id)
  end

  def load_client_and_category
    @clients = Client.all
    @car_category = CarCategory.all
  end
end