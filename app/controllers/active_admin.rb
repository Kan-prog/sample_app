ActiveAdmin.register User do

  before_action :access_denied

  controller do
    def access_denied #管理者画面へのアクセス拒否挙動
      if current_user && current_user.password == admin_user_url.password && current_user.email == admin_user_url.password
        redirect_to admin_root_path, alert: I18n.t('active_admin.access_denied.message')
      elsif current_user && (current_user.password != admin_user_url.password || current_user.email != admin_user_url.password)
        redirect_to root_path, alert: "アクセスできません"
      else
        redirect_to login_path, alert: "ログインしてください"
      end
    end
  end

end