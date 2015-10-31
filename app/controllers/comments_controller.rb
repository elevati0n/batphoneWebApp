class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @comment =  Comment.build # @micropost.comments.build(user_id: @micropost.user.id)
  end

  def show



  end

  def index
    @comments = Comment.all
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "comments added!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end

  end


  private

  def comment_params
    params.require(:comment).permit(:user_id, :micropost_id, :text) #).require(:micropost_id).require( permit(:text, :email, :password, :password_confirmation)
  end

end
