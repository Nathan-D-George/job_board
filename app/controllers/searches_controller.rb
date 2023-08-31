class SearchesController < ApplicationController
  def search
    @search = User.new
    users   = params[:results] if params[:results].present?
    @users  = []
    users.each {|user| @users.append(User.find(user.to_i))} if users.present?
  end

  def results
    if params[:user][:search_word].present?
      users_results = User.where("name LIKE ?", "%#{params[:user][:search_word]}%").all
    else
      users_results = []
    end
    ids = []
    users_results.each {|user| ids.append(user.id)}
    redirect_to search_path(results: ids)
  end
end
