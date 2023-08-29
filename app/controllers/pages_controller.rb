class PagesController < ApplicationController
  def home
    @photo = "https://images.unsplash.com/photo-1559780530-28f4e94b4bad?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGJpbm9jdWxhcnN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60"
  end

  def about
    @photo = "https://images.unsplash.com/photo-1560264280-88b68371db39?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8d29yayUyMG9mZmljZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"
  end
end
