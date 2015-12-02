class DevicesController < ApplicationController

  def new
    @current_network = Network.find(params[:network_id])
    @device = @current_network.devices.new
  end

  def create

    #@micropost = current_user.microposts.build(micropost_params)

    @device = Network.find(params[:network_id]).devices.new(devices_params)
    if @device.save
      flash[:success] = "Device Added!"
      redirect_to devices_path
    else
      flash[:danger] = "FAILURE FAILURE"
      render 'new'
    end

  end

  def show
    @device = Device.find(params[:id])
  end

  def index
    if !(params[:network_id] == nil)
      @devices = Network.find(params[:network_id]).devices
      if @devices.count == 0
        flash[:danger] = "No Devices found, please add your devices"
        redirect_to new_network_device_path
      end
    else
      @devices = Device.all
    end
  end

  def edit
    @device = Device.find(params[:id])
  end




  def destroy
  end

  private

  def devices_params
    params.require(:device).permit(:IP_address, :MAC, :AP_SSID, :Gateway_mode, :name,
                                   :description, :longitude, :latitude, :notes, :network_id)
  end


end
