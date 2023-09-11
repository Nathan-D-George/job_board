class PostsController < ApplicationController
  before_action :logged_in_only
  before_action :post_owner_only, only: [:edit, :destroy]
  def new
    @post = Post.new
  end

  def create
    post = Post.new
    post.title   = params[:post][:title]
    post.body    = params[:post][:body]  if params[:post][:body].present?
    post.image   = params[:post][:image] if params[:post][:image].present?
    post.user_id =  Current.user.id
    if post.save
      flash[:notice] = "Post Created"
      redirect_to show_post_path(id: post.id)
    else
      flash[:alert]  = "Something went wrong"
      render :new
    end
  end

  def show
    @post   = Post.find(params[:id].to_i)
    @poster = User.find(@post.user_id)
  end

  def list
    @posts = Post.all.order(id: :desc)
  end

  def edit
    @post = Post.find(params[:id].to_i)
  end

  def update
    post = Post.find(params[:id].to_i)
    post.title = params[:post][:title]
    post.body  = params[:post][:body]  if params[:post][:body].present?
    post.image = params[:post][:image] if params[:post][:image].present?
    if post.save
      flash[:notice] = 'Post Updated'
      redirect_to show_post_path(id: post.id)
    else
      flash[:alert]  = 'Something went wrong'
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id].to_i)
    @post.destroy
    flash[:notice] = 'Post successfully Deleted!'
    redirect_to root_path
  end

  private

  def post_owner_only
    post = Post.find(params[:id].to_i)
    user = User.find(post.user_id)
    redirect_to list_posts_path, alert: 'Only the Poster can do this.' if user.id != Current.user.id
  end

end
