class StaticPagesController < ApplicationController
  def home
    @microposts = Micropost.all.paginate(page: params[:page])
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
