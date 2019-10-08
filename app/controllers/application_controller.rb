class ApplicationController < ActionController::Base
  before_action :set_global_search_variable

  protect_from_forgery with: :exception
  include SessionsHelper
  
  # 検索はどこのページからでもしたいので、applicationコントローラ内に定義
  def set_global_search_variable
    @q = Micropost.ransack(params[:q])
    @genres = Genre.all.order(:name)
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
    
    # def access_denied #管理者画面へのアクセス拒否挙動
    #   if current_user && current_user.password == admin_user_url.password && current_user.email == admin_user_url.password
    #     redirect_to admin_root_path, alert: I18n.t('active_admin.access_denied.message')
    #   elsif current_user && (current_user.password != admin_user_url.password || current_user.email != admin_user_url.password)
    #     redirect_to root_path, alert: "アクセスできません"
    #   else
    #     redirect_to login_path, alert: "ログインしてください"
    #   end
    # end
    
    
end
