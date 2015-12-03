class RecordingsController < ApplicationController
  def new
    @recording = Recording.new
    @devices = Device.all
    @networks = Network.all
  end

  def create
    @recording = Recording.new(recording_params)
    #@device = Network.find(params[:network_id]).devices.new(devices_params)

    if @recording.save
      flash[:success] = "recording added!"
      redirect_to root_url
      end
  end

  def edit
    @recording = Recording.new
  end

  def show
    @recording = Recording.find(:id)
  end

  def index
    @recordings = Recording.all
  end



  private

  def recording_params
    params.require(:recording).permit(:originator, :time, :date, :URI, :device_id, :network_id)
  end


end
