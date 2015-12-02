class CommentsController < ApplicationController
  #before_action :logged_in_user, only: [:create, :destroy]
  #before_action :correct_user,   only: :destroy

  def new
    #@comment =  @micropost.comments.build(user_id: current_user.id)
  end

  def show
    redirect_to home_path

    #@comment = Comment.find(params[:id])
    #@comments = Comment.all

  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "comment deleted"
    redirect_to request.referrer || root_url
  end

  def index
    redirect_to home_path

    #@comments = Comment.find(user_id: current_user.id)
  end

  def create

    #@micropost = Micropost.find(comment_params[:micropost_id])
    #@comment =  @micropost.comments.build(user_id: current_user.id)
    @comment =  Comment.new(comment_params)


    if @comment.save
      flash[:success] = "comments added!"
      redirect_to request.referrer || root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end

  end


  private

  def comment_params
    params.require(:comment).permit(:user_id, :micropost_id, :network_id, :text)
  end


end
