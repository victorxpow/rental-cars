class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def show
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(client_params)
    return redirect_to @client,
          notice: 'Registrado com sucesso'if @client.save
    
    render :new
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    return redirect_to @client,
    notice: t('.success') if @client.update(client_params)

    render :edit
  end

  def destroy
    @client = Client.find(params[:id])
    return redirect_to clients_path,
    notice: t('.success') if @client.destroy

    redirect_to :show
  end

  private

  def client_params
    params.require(:client).permit(:name, :cpf, :email)
  end
end