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
    # 送信したメッセージ
    @active_messages = Message.where(user_id: current_user.id).includes(:receive_user)
    @user_active_messages = Message.where(id: send_ids).includes(:receive_user)
    # 受信したメッセージ
    @receive_messages = Message.where(receive_user_id: current_user.id).includes(:user)
    @user_receive_messages = Message.where(id: receive_ids).includes(:user)
  end

  def create
    @user = User.find(params[:user_id])
    @message = current_user.messages.build(message_params)
    @message.receive_user_id = @user.id
    @send_user = current_user
    if @message.save
      @message.create_notification_by(current_user)
      flash[:success] = @user.name + 'さんへメッセージを送信しました。'
      NotificationMailer.notification_mail(@user, @send_user, @message).deliver
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
    @receive_messages = Message.where(receive_user_id: current_user.id).includes(:user)
  end
  
  private
    
    def message_params
      params.require(:message).permit(:content)
    end
end
