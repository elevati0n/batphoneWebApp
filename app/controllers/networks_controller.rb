class NetworksController < ApplicationController
  def new
    @network = Network.new
  end

  def show
   @network = Network.find(params[:id])
  end

  def create
     @network = Network.new(network_params)
     if @network.save
       flash[:success] = "Network added!"
       redirect_to @network
     else
       flash[:success] = "Network failed to add!"
      render 'new'
    end
  end

  def index
    @networks = Network.paginate(page: params[:page])
  end


  private

  def network_params
    params.require(:network).permit(:name, :publickey)
    end
  end

