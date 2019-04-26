class SessionsController < ApplicationController
  def new
  end
  
  def create
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
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
