class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update, :destroy, :likes, :user_message]
  before_action :correct_user,   only: [:edit, :update, :destroy, :user_message]
  
  def index
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    # debugger
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if Rails.env.production?
      recaptcha_valid = verify_recaptcha(model: @user, action: 'registration')
      if recaptcha_valid
        if @user.save
          @user.send_activation_email
          flash[:info] = "お客様のメールアドレスに登録確認メールを送りましたので確認お願いします。"
          redirect_to root_url
        else
          render "new"
        end
      else
        render 'new'
      end  
    elsif Rails.env.development?
      if @user.save
        @user.send_activation_email
        flash[:info] = "お客様のメールアドレスに登録確認メールを送りましたので確認お願いします。"
        redirect_to root_url
      else
        render "new"
      end
    end  
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました！"
      redirect_to @user
    else
      render 'edit'
    end  
  end
  
  def destroy
    if current_user.admin = true
      @user = User.find(params[:id])
      User.find(params[:id]).destroy
      flash[:success] = @user.name + "を削除しました"
      redirect_to users_url
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page]).includes(:user)
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture, :description, :gender, :grade, :college_id)
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "権限がありません。"
        redirect_to(root_url)
      end  
    end
    
    
    
    
end
