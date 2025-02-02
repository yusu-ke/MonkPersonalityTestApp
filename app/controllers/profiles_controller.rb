class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to user_info_profile_path, success: "更新しました"
    else
      flash.now["danger"] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def user_info;end

  def show
    @posts = current_user.posts
    @locations = Map.joins(:post).where(posts: { user_id: current_user.id })
    gon.locations = map_locations(@locations)
  end

  private

  def set_user
    if current_user.nil?
      redirect_to root_path, alert: "ログインが必要です。"
    else
      @user = User.find(current_user.id)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def map_locations(locations)
    locations.map do |location|
      {
        latitude: location.latitude,
        longitude: location.longitude,
        address: location.address,
        marker_image: location.marker_image,
        link: post_path(location.post_id)
      }
    end
  end
end
