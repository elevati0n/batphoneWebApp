class StreamsController < ApplicationController
#  include Rack::Stream::DSL


  def new
    @stream = Stream.new
    @networks = Network.all
    @devices = Device.all
    #render :nothing => true
  end

  def create
    @stream = Stream.new(stream_params)
    if @stream.save
      `ssh -n -f -vvv -p 2222 -L 18886:192.168.2.6:22 root@129.10.248.216
          "sudo ffplay -nodisp -fflags nobuffer -f mpegts -i tcp://104.131.44.2:18882"`
      #`ssh -vvv -p 18886 localhost `
      redirect_to @stream
    end


  end

  def show

    @stream = Stream.find(params[:id])

  end

  def update


  end

  def index
    @streams = Stream.all
  end

  def edit



  end

  def destroy


  end

private

  def stream_params
  params.require(:stream).permit(:port, :device_id, :user_id, :network_id)
  end


end
