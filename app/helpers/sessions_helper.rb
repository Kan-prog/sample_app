module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end
  
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && !user.activated? && user.authenticated?(:activation, params[:id])
        log_in user
        @current_user = user
      end
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
    flash[:success] = "ログアウトしました。"
  end
  
  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  # 要ログイン操作で弾かれた場合のログイン後のページ遷移で使用
  def redirect_back_or(default)
    # forwarding_urlがない場合は、default(基本はユーザーページ)へリダイレクト
    redirect_to(session[:forwarding_url] || default)
    # ログイン後はforwading_urlをクリアにしておく
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    # ActionDispatch::Request クラスでoriginal_urlメソッドは定義されている
    session[:forwarding_url] = request.original_url if request.get?
  end
end
