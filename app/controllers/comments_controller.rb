class CommentsController < ApplicationController
  $post_id = nil
  $comment_id = nil
  before_action :logged_in_only

  def create
    comment = Comment.new
    comment.post_id = $post_id
    comment.user_id = Current.user.id
    comment.content = params[:comment][:content]
    if comment.save
      flash[:notice] = 'Comment saved'
    else
      flash[:alert]  = 'Something went wrong.'
    end
    redirect_to list_comments_path(id: $post_id)
  end

  def list
    @comment  = Comment.new
    @comments = Comment.where(post_id: params[:id]).all.order(id: :desc)
    $post_id  = params[:id].to_i
    @post     = Post.find(params[:id].to_i)
  end

  def edit
    @comment = Comment.find(params[:id])
    $comment_id = params[:id].to_i
  end

  def update
    comment  = Comment.find($comment_id)
    comment.content = params[:comment][:content]
    if comment.save
      flash[:notice] = 'Comment updated'
      redirect_to list_comments_path(id: $post_id)
    else
      flash[:alert]  = "something went wrong"
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to list_comments_path(id: $post_id)
  end
end
