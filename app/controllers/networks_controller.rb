class NetworksController < ApplicationController
  def new
    @network = Network.new
  end

  def show
   @network = Network.find(params[:id])
   @devices = @network.devices.all
  end

  def create
     @network = Network.new(network_params)
     if @network.save
       flash[:success] = "Network added!"
       redirect_to @network
     else
       flash[:danger] = "Network failed to add!"
      render 'new'
    end
  end

  def index
    @networks = Network.paginate(page: params[:page])
    @network_array = @networks.all.map { |network| [network.name, network.id] }
  end

  def destroy
    @network = Network.find(params[:id])
    @network.destroy
    flash[:danger] = "network deleted"
    redirect_to request.referrer || root_url
  end


  private

  def network_params
    params.require(:network).permit(:name, :publickey)
    end
  end

