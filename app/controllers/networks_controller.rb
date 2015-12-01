class NetworksController < ApplicationController
 
def say
@network = Network.find(params[:id]) 
 @devices = @network.devices.all 
 @hash = Gmaps4rails.build_markers(@network.devices) do |device, marker| 
 marker.lat device.latitude 
 marker.lng device.longitude 
 marker.picture({"url" => "https://lh3.googleusercontent.com/YKh2bl1P53SCWfZplfmP5rpKDQIAiJAQCqLnFSXFUy8eMV5UOZW8YJiy7HHShH-qoMH7PwKSwo8=s50-h50-e365","width" =>  50,"height" => 50}) 
 marker.json({:id => device.id }) 
 marker.infowindow render device 
end
end


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


