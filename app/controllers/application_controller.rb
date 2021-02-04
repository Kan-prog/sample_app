class ApplicationController < ActionController::Base
  before_action :set_global_search_variable

  protect_from_forgery with: :exception
  include SessionsHelper
  
  # 検索はどこのページからでもしたい(navbarに設置したい)ので、applicationコントローラ内に定義
  # search_form_for内で使う@q検索パラメータと@genresを取得できるようにしておく
  def set_global_search_variable
    @q = Micropost.ransack(params[:q])
    @genres = Genre.all.order(:name)
    logger.debug("applicationコントローラー")
    logger.debug(@q)
  end
  
  private
  
     # ログイン済みユーザーかどうか確認
    def logged_in_user
      # loginが必要な操作でloginしていない場合、requestを受けたurlを保存し、ログインページへリダイレクト
      # その後loginした場合は、session[:forwarding_url]に再遷移させる
      unless logged_in?
        # requestを受けたurlをsesstion[:forwarding_url]に登録
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
