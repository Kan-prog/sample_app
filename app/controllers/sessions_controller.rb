class SessionsController < ApplicationController
  def new
  end
  
  # def create
  #   # authを参照
  #   auth = request.env["omniauth.auth"]
  #   # 参照先のauthがあるかどうかの確認
  #   if auth.present?
  #     # 新規ユーザーの場合、authからユーザーを見つけ出し、情報を取得しユーザー作成
  #     unless @auth = Authorization.find_from_auth(auth)
  #       @auth = Authorization.create_from_auth(auth)
  #     end
  #     # userにSNSアカウントから作成したユーザーを代入し、ログイン
  #     user = @auth.user
  #     log_in(user)
  #     flash[:success] = "ようこそ" + current_user.name + "様!"
  #     redirect_back_or user
  #     # email,passwordログイン
  #   else
  #     user = User.find_by(email: params[:session][:email].downcase)
  #     if user && user.authenticate(params[:session][:password])
  #       if user.activated?
  #         log_in user
  #         params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  #         flash[:success] = "ようこそ" + current_user.name + "様!"
  #         redirect_back_or user
  #       else
  #         message  = "アカウントが有効になっていません。 "
  #         message += "登録時に送信されたメールを確認してください。"
  #         flash[:warning] = message
  #         redirect_to root_url
  #       end
  #     else
  #       flash.now[:danger] = 'パスワードまたはメールアドレスが間違っています。'
  #       render 'new'
  #     end
  #   end
  # end
  
  # def create
  #   # reCAPTCHA
  #   # if Rails.env.production?
  #     success = verify_recaptcha(action: 'login', minimum_score: 0.5)
  #     checkbox_success = verify_recaptcha unless success
  #     # SNSログイン
  #     auth = request.env['omniauth.auth']
  #     if auth.present?
  #       @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
  #       log_in @user
  #       # session[:user_id] = user.id
  #       params[:uid] = @user.id
  #       flash[:success] = "ようこそ"+ @user.name + "様！"
  #       redirect_to @user
  #     #既存パタン
  #       # email,passwordログイン
  #     elsif success || checkbox_success
  #       user = User.find_by(email: params[:session][:email].downcase)
  #       if user && user.authenticate(params[:session][:password])
  #         if user.activated?
  #           log_in user
  #           params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  #           flash[:success] = "ようこそ" + current_user.name + "様!"
  #           redirect_back_or user
  #         else
  #           message  = "アカウントが有効になっていません。 "
  #           message += "登録時に送信されたメールを確認してください。"
  #           flash[:warning] = message
  #           redirect_to root_url
  #         end
  #       else
  #         flash.now[:danger] = 'パスワードまたはメールアドレスが間違っているようです。'
  #         render 'new'
  #       end
  #     else
  #       if !success
  #         @show_checkbox_recaptcha = true
  #       end
  #       render 'new'
  #     end
  #   # elsif Rails.env.development?  
  #   #   user = User.find_by(email: params[:session][:email].downcase)
  #   #     if user && user.authenticate(params[:session][:password])
  #   #       if user.activated?
  #   #         log_in user
  #   #         params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  #   #         flash[:success] = "ようこそ" + current_user.name + "様!"
  #   #         redirect_back_or user
  #   #       else
  #   #         message  = "アカウントが有効になっていません。 "
  #   #         message += "登録時に送信されたメールを確認してください。"
  #   #         flash[:warning] = message
  #   #         redirect_to root_url
  #   #       end
  #   #     else
  #   #       flash.now[:danger] = 'パスワードまたはメールアドレスが間違っているようです。'
  #   #       render 'new'
  #   #     end
  #   # end  
  # end
  
  def create
      # SNSログイン
      auth = request.env['omniauth.auth']
      if auth.present?
        user = User.find_or_create_from_auth(request.env['omniauth.auth'])
        log_in user
        # session[:user_id] = user.id
        params[:uid] = user.id
        flash[:success] = "ようこそ"+ user.name + "様！"
        redirect_to user
      # email,passwordログイン
      else
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          if user.activated?
            log_in user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            flash[:success] = "ようこそ" + current_user.name + "様!"
            redirect_back_or user
          else
            message  = "アカウントが有効になっていません。 "
            message += "登録時に送信されたメールを確認してください。"
            flash[:warning] = message
            redirect_to root_url
          end
        else
          flash.now[:danger] = 'パスワードまたはメールアドレスが間違っているようです。'
          render 'new'
        end
      end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
