class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  
  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "出品しました！"
      redirect_to root_url
    else
      @microposts = Micropost.all.page(params[:page])
      flash.now[:danger] = '出品に失敗しました。'
      render new_micropost_path
    end
  end
  
  def show
    @micropost = Micropost.find(params[:id])
  end

  def edit
    @micropost = Micropost.find_by(id: params[:id])
  end

  def update
    @micropost = Micropost.find_by(id: params[:id])
    if @micropost.update(micropost_params)
        flash[:success] = "出品内容は正常に更新されました"
        redirect_to root_url
    else
        flash.now[:danger] = "出品内容は更新されませんでした"
        render :edit
    end
    # @micropost = Micropost.find_by(id: current_user.microposts.id)
    # if @micropost.update_attributes(micropost_params)
    #   flash[:success] = "出品内容を更新しました！"
    #   redirect_to @micropost
    # else
    #   render 'edit'
    # end  
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = "出品を取り消しました。"
    redirect_to request.referrer || root_url
  end
  
  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture, :name, :price, :cost)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
    
end
