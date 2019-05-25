class FavoritesController < ApplicationController
  before_action :logged_in_user
  def create
    micropost = Micropost.find_by(id: params[:micropost_id])
    # micropost.id = params[:micropost_id]
    # selfの部分に@micropost,@messageが入る
    micropost.create_notification_by(current_user)
    current_user.like(micropost)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    micropost = Micropost.find_by(id: params[:micropost_id])
    current_user.unlike(micropost)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end
end
