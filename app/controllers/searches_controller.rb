class SearchesController < ApplicationController
  before_action :logged_in_only
  
  def search
    @search = User.new
    @search.name = params[:results][:name]        if params[:results].present? && params[:results][:name].present?
    users   = params[:results][:user_ids]         if params[:results].present? && params[:results][:user_ids].present?
    @users  = []
    users.each {|user| @users.append(User.find(user.to_i)) if User.find(user.to_i).companies.blank?} if users.present? 

    companies  = params[:results][:company_ids]   if params[:results].present? && params[:results][:company_ids].present?
    @companies = []
    companies.each {|company| @companies.append(Company.find(company.to_i))} if companies.present?
    
    jobs  = params[:results][:job_ids]            if params[:results].present? && params[:results][:job_ids].present?
    @jobs = []
    jobs.each{|job| @jobs.append(Job.find(job.to_i))} if jobs.present?

    @categories = []
    categories  = Category.all
    categories.each {|category|
      @categories.append(category.name) if category.name
    }
    console
  end

  def results
    if params[:user][:name].present?
      users_results   = User.where("name LIKE ?",    "%#{params[:user][:name]}%").all
      company_results = Company.where("name LIKE ?", "%#{params[:user][:name]}%").all

      category_names      = params[:user][:categories]
      job_initial_results = Job.where("name LIKE ?", "%#{params[:user][:name]}%").all
      job_final_results   = []
        if category_names.length > 1
          job_initial_results.each {|job|
          category_names.each{|category_name|
            job_final_results.append(job) if job.categories.include?(Category.where(name: category_name).first)
          }
        }
      else
        job_final_results = job_initial_results
      end
    else
      users_results     = []
      company_results   = []
      job_final_results = []
    end

    users_ids = []
    users_results.each {|user| users_ids.append(user.id)}
    company_ids = []
    company_results.each {|company| company_ids.append(company.id) }
    job_ids = []
    job_final_results.each{|job| job_ids.append(job.id)}

    redirect_to search_path(results: {user_ids: users_ids, company_ids: company_ids, job_ids: job_ids, name: params[:user][:name]})
  end
end
