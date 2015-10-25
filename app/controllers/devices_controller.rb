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
      flash[:success] = "FAILURE FAILURE"
      render 'new'
    end

  end

  def show
    @devices = Device.all
  end

  def index
    @devices = Device.all
  end




  def destroy
  end

  private

  def devices_params
    params.require(:device).permit(:IP_address, :MAC, :AP_SSID, :Gateway_mode, :name,
                                   :description, :location, :notes, :network_id)
  end


end
