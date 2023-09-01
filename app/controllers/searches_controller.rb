class SearchesController < ApplicationController
  def search
    @search = User.new
    users   = params[:results][:user_ids] if params[:results].present? && params[:results][:user_ids].present?
    @users  = []
    users.each {|user| @users.append(User.find(user.to_i)) if User.find(user.to_i).companies.blank?} if users.present? 

    companies  = params[:results][:company_ids] if params[:results].present? && params[:results][:company_ids].present?
    @companies = []
    companies.each {|company| @companies.append(Company.find(company.to_i))} if companies.present?
    console
  end

  def results
    if params[:user][:search_word].present?
      users_results   = User.where("name LIKE ?", "%#{params[:user][:search_word]}%").all
      company_results = Company.where("name LIKE ?", "%#{params[:user][:search_word]}%").all
    else
      users_results = []
      company_results = []
    end
    users_ids = []
    users_results.each {|user| users_ids.append(user.id)}
    company_ids = []
    company_results.each {|company| company_ids.append(company.id) }
    redirect_to search_path(results: {user_ids: users_ids, company_ids: company_ids })
  end
end
