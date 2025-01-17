class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "入力されたメールアドレスに再設定メールを送信いたしました。"
      redirect_to root_url
    else
      flash[:info] = "入力されたメールアドレスに再設定メールを送信いたしました。"
      redirect_to root_url
    end
  end

  def edit
  end
  
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "パスワードの再設定が完了しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
    
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        flash[:danger] = "ユーザー情報が正しくありません。"      
        redirect_to root_url
      end
    end
    
    # 期限切れかどうかを確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワード再設定の期限が切れています。"
        redirect_to new_password_reset_url
      end
    end
end