class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)

    @networks = Network.all
    #@network_array = @networks.all.map { |network| [network.name, network.id] }

    @devices = Device.all

    if micropost_params[:audience == :private] and !micropost.network.publickey.nil?
      @micropost.text = GPGME::Key.import(network.publickey)

    end

    if @micropost.save
      flash[:success] = "Meshage saved!"
      redirect_to root_url
    else
	  @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def index
    @microposts = Micropost.paginate(page: params[:page])

  end



  def show
    @micropost = Micropost.find(params[:id])
    #@comments = @micropost.comments
    #@network = micropost.network



    #@Device = Device.find(micropost.device_id)


  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture, :subject,
                                        :network_id, :device_id, :private)
    end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

end