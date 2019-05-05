class ApplicationController < ActionController::Base
  before_action :set_global_search_variable

  protect_from_forgery with: :exception
  include SessionsHelper
  
  # 検索はどこのページからでもしたいので、applicationコントローラ内に定義
  def set_global_search_variable
    @q = Micropost.ransack(params[:q])
    @genres = Genre.all
  end
  
  private
  
     # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
end
