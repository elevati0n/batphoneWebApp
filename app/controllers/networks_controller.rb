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
   @mic_ids = @network.micropost_ids
   if logged_in?
   @feed1 = Micropost.where(user_id: current_user.id)
   @feed2 = !network.private?
   @feed3 = current_user.network.find_by_id(params[:id])
     @feed= @feed1.join(@feed2).join(@feed3)
   end
       #current_user.feed.paginate(page: params[:page])
   #@hash = Gmaps4rails.build_markers(@network.devices)
  end

  def create
     @network = Network.new(network_params)
     @network.build(:admin_id => current_user.id )
     if @network.save
       flash[:success] = "Network added!"
       redirect_to @network
     else
       flash[:danger] = "Network failed to add!"
      render 'new'
    end
  end

def edit
  @network = Network.find(params[:id])
end

def update
  @network = Network.find(params[:id])
  if @network.update_attributes(network_params)
    flash[:success] = "Network updated!"
    redirect_to @network
  else
    render 'edit'
  end
end

  def index
    @networks = Network.paginate(page: params[:page])
    @devices = Device.all
    @network_array = @networks.all.map { |network| [network.name, network.id] }
  end

  def destroy
    @network = Network.find(params[:id])
    @network.destroy
    flash[:danger] = "network deleted"
    redirect_to request.referrer || root_url
  end

  def join
    Network.find(params).add_user.(params)

  end


  private

  def network_params
    params.require(:network).permit(:name, :publickey, :admin_id, :ssh_key, :private, :key_type)
  end

end


