class SubsidiariesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def edit
    @subsidiary = Subsidiary.find(params[:id])
  end

  def update
    @subsidiary = Subsidiary.find(params[:id])

    return redirect_to @subsidiary,
    notice: t('.success') if @subsidiary.update(subsidiary_params)

    render :edit
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)

    return redirect_to @subsidiary, notice: t('.success') if @subsidiary.save

    render :new
  end

  def destroy
    @subsidiary = Subsidiary.find(params[:id])

    return redirect_to subsidiaries_path, 
    notice: t('.success') if @subsidiary.destroy

    redirect_to :show
  end

  private

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end
end
