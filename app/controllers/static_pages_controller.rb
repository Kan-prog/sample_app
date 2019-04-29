class StaticPagesController < ApplicationController
  # before_action :set_search, only: [:home]
  # before_action :result_search,　only: [:home]
  
  # def set_search
  #   @q = Micropost.ransack(params[:q])
  #   @microposts = @q.result.includes(:user).page(params[:page])
  #   @genres = Genre.all
  # end
  
  def home
    @result_microposts = Micropost.all
  #   # homeページに検索結果を表示
    
  #   unless  params[:q] = []? 
  #     @q = Micropost.search(search_params)
  #     @result_microposts = @q.result.includes(:user).page(params[:page])
  #     @genres = Genre.all
  #   else
  #     params[:q] = []  
  #     @result_microposts = Micropost.all
  #     @genres = Genre.all
  #   end  
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  private
    
    # def search_params
    #   params.require(:q).permit(:name_cont, :genres_id_in => [])
    # end
  
end
