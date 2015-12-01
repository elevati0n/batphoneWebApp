module NetworksHelper
def marker_info(marker) 
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
end
