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
