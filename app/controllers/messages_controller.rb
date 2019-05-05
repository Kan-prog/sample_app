class MessagesController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    # ログインユーザーが送ったメールのidの中から、あるユーザー@userのidを探す
    send_ids = current_user.messages.where(receive_user_id: @user.id).pluck(:id)
    # 上の逆
    receive_ids = @user.messages.where(receive_user_id: current_user.id).pluck(:id)
    # メッセージ全体の中から、send_idsとreceive_idsを共通して持つメールを特定
    @messages = Message.includes(:user).where(id: send_ids + receive_ids).order(created_at: :desc)
    @message = Message.new
  end

  def create
    @user = User.find(params[:user_id])
    @message = current_user.messages.build(message_params)
    @message.receive_user_id = @user.id
    @message.create_notification_by(current_user)
    if @message.save
      flash[:success] = @user.name + 'さんへメッセージを送信しました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = @user,name + 'さんへメッセージを送信できませんでした。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def your_message
    @active_messages = Message.where(user_id: current_user.id).includes(:receive_user)
    @receive_messages = Message.where(receive_user_id: current_user.id)
  end
  
  private
    
    def message_params
      params.require(:message).permit(:content)
    end
end
