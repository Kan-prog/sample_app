class FavoritesController < ApplicationController
  before_action :logged_in_user
  def create
    micropost = Micropost.find_by(id: params[:micropost_id])
    current_user.like(micropost)
    redirect_to root_url
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unlike(micropost)
    redirect_to root_url
  end
end
