class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  
  def index
    @genres = Genre.all
    unless params[:q].blank?
      @q = Micropost.search(search_params)
      @result_microposts = @q.result.paginate(:page => params[:page])
    else
      @result_microposts = Micropost.all.paginate(:page => params[:page])
    end
  end
  
  def search
    index
    render :index
  end
  
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
        redirect_to micropost_path(@micropost)
    else
        flash.now[:danger] = "出品内容は更新されませんでした"
        render :edit
    end
  end
  
  def update_sold
    @micropost = Micropost.find_by(id: params[:id])
    if @micropost.sold == false
      @micropost.update_attributes(sold: true)
      flash[:success] = "出品を締め切りました"
      redirect_to micropost_path(@micropost)
    elsif @micropost.sold == true
      @micropost.update_attributes(sold: false)
      flash[:success] = "締め切り解除しました"
      redirect_to micropost_path(@micropost)
    end  
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = "出品を取り消しました。"
    redirect_to root_url
  end
  
  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture, :picture_1, :picture_2, :picture_3, :name, :price, :cost, {genre_ids: []})
    end
    
    def sold_params
      params.require(:micropost).permit(:sold)
    end
    
    def search_params
      params.require(:q).permit(:name_cont,  :price_gteq, :price_lteq, :genres_id_in => [])
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
    
end
