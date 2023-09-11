class FriendshipsController < ApplicationController
  before_action :logged_in_only

  def create
    return if Current.user.already_friends_with?(params[:id])
    friendship         = Friendship.new(friend_id: params[:id].to_i)
    friendship.user_id = Current.user.id
    if friendship.save
      flash.now[:notice] = "Following #{User.find(params[:id].to_i).name}"
    else
      flash.now[:alert]  = "Something went wrong..."
    end
    redirect_to show_user_path(id: params[:id].to_i)
  end

  def delete
    @friendship = Friendship.where(user_id: Current.user.id, friend_id: params[:id].to_i).first
    @friendship.destroy
    flash[:notice] = "User Unfollowed"
    redirect_to show_user_path(id: params[:id].to_i)
  end
end
