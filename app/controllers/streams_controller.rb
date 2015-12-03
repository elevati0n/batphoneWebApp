class StreamsController < ApplicationController


  def new
    @stream = Stream.new
    @networks = Network.all
    @devices = Device.all
    #render :nothing => true
  end

  def create
    @stream = Stream.new(stream_params)
    if @stream.save
      `ssh -n -f -vvv -p 2222 -L 18886:root@192.168.2.6:22 root@129.10.248.216 "sudo ffplay -nodisp -fflags nobuffer -f mpegts -i tcp://104.131.44.2:18882 &"`
      redirect_to @stream
    end


  end

  def show

    @stream = Stream.find(params[:id])


  end


  def Stream6Broadcasting
    @network = Network.first


    @stream = Stream.new(:network_id => 1, :port => "18886", :device_id => 6)
    `ssh -n -f -vvv -p 2222 -R 18880:root@192.168.2.6:22 root@129.10.248.216 "arecord -f cd -Dhw:sndrpiwsp | ffmpeg -fflags nobuffer -i - -acodec libmp3lame -q:a 6 -ac 2 -re -f mpegts udp://192.168.2.6:1234"`
    flash[:success] = "Broadcasting stream created at Recording Pi Node 6!"

    @stream = Stream.new(:network_id => 1, :port => "18886", :device_id => 6)

    redirect_to @network

  end

  def ForwardStreamThroughNode
    `ssh -n -f -vvv -p 2222 -R 18881:root@192.168.2.6:22 root@129.10.248.216 " ffmpeg -i udp://192.168.2.7:1234 -acodec copy -f mpegts udp://192.168.2.8:1234`
    flash[:success] = "Forwarding audio stream from Recording Pi .7 to Recording Pi .8"

    @network = Network.first
    @stream = Stream.new(:network_id => 1, :port => "18886", :device_id => 6)

    redirect_to @network
  end


  def CreateStreamDeviceRecieving
    `ssh -n -f -vvv -p 2222 -R 18880:root@192.168.2.6:22 root@129.10.248.216 " ffplay -fflags nobuffer -nodisp -f mpegts -i udp://192.168.2.6:1234`
    flash[:success] = "Recording Pi 8 is now recieving the audio stream"

    @network = Network.first
    @stream = Stream.new(:network_id => 1, :port => "18886", :device_id => 6)

    redirect_to @network
  end




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

