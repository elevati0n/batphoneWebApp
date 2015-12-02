class StreamsController < ApplicationController
  def new
    @stream = Stream.new
    @networks = Network.all
    @devices = Device.all
  end

  def create
    @stream = Stream.new(stream_params)
    execCommands

  end

  def show


  end

  def update


  end

  def edit



  end

  def destroy


  end

private

  def stream_params
  params.require(:stream).permit(:port, :device_id, :user_id, :network_id)
  end

  def execCommands
    @fileSpace = IO.popen("date") { |f| puts f.gets }
  end

end