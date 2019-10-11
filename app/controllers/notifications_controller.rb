class NotificationsController < ApplicationController
  before_action :logged_in_user
  
  include NotificationsHelper
  def index
    @notifications = current_user.passive_notifications.paginate(page: params[:page], per_page: 10).includes(:message, :micropost)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
  
  def destroy
    @notification = Notification.find_by(id: params[:id])
    @notification.destroy
  end
  
  def destroy_all
    @notifications = current_user.passive_notifications.all
    @notifications.destroy
  end
end
