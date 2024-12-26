class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: "更新しました"
    else
      flash.now["danger"] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @posts = current_user.posts
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
