class LikesController < ApplicationController
  before_action :logged_in_only

  def create
    like = Like.new
    like.user_id = Current.user.id
    like.post_id = params[:id].to_i
    if like.save
      flash.now[:notice] = "Liked post"
    else
      flash.now[:alert]  = "Something went wrong"
    end
    redirect_to list_posts_path
  end

  def destroy
    @like = Like.where(user_id: Current.user.id, post_id: params[:id].to_i).first
    @like.destroy
    redirect_to list_posts_path
  end
end
