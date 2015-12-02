class StreamsController < ApplicationController
#  include Rack::Stream::DSL


  def new
    @stream = Stream.new
    @networks = Network.all
    @devices = Device.all
    render :nothing => true
  end

  def create
    @stream = Stream.new(stream_params)
    render :json => {
               :text             => params[:text],
               :stream_transport => stream_transport
           }

    if @stream.save
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

  def execCommands
    @fileSpace = IO.popen("date") { |f| puts f.gets }
  end

end
