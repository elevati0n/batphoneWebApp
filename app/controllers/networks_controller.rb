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
       flash[:success] = "Network failed to add!"
      render 'new'
    end
  end

  def index
    @networks = Network.paginate(page: params[:page])
  end

  def destroy
    @network = Network.find(params[:id])
    @network.destroy
    flash[:success] = "network deleted"
    redirect_to request.referrer || root_url
  end


  private

  def network_params
    params.require(:network).permit(:name, :publickey)
    end
  end

