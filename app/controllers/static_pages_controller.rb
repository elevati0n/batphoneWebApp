class StaticPagesController < ApplicationController

  def home
    if logged_in?
      #Replace with networks user is subscribed to.
      @networks = Network.all
      @network_array = @networks.all.map { |network| [network.name, network.id] }

      #Replace with a look up of a specific network's device?
      @devices = Device.all
      @device_array = @devices.all.map { |device| [device.name, device.id] }

      @micropost  = current_user.microposts.build

      @microposts = current_user.microposts.all

      @microposts.each do |p|
        @comments = p.comments
        #@network = p.network
        @comment = p.comments.build
      end

      #@microposts.each do |p|
      #  @comments = p.comments
      #  @comment = p.comments.build
      #end

      @feed_items = current_user.feed.paginate(page: params[:page])
      #@comment = @micropost.comments.build


    end
  end

  def help
  end

  def about
  end
  
  def contact
  end
end
