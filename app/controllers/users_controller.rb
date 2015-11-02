class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

    @comment = Comment.new

    #@comments = @microposts.each { |micropost| micropost.comments.build }


    #for_each @microposts |m|
    #
    #  @comments = @m.paginate(page: params[:page])


  end

  def new
	@user = User.new
  end

 def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
	flash[:success] = "Welcome to the Bat-Phone Web App!"
      redirect_to @user
    else
      render 'new'
    end
 end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def index
    @users = User.paginate(page: params[:page])

  end

  private

	def user_params
	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end


end
