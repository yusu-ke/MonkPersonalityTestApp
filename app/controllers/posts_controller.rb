class PostsController < ApplicationController
  before_action :set_post, only: %i[ edit update destroy ]
  before_action :authenticate_user!

  def index
    @q = Post.joins(:map).ransack(params[:q] || {})
    @posts = @q.result(distinct: false).includes(:user, :view_counts).order(created_at: :desc)
    @no_results = @posts.empty?

    if params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    else
      @posts = Post.all
    end

    # 全ユーザーのマップ情報を取得
    gon.locations = Map.locations_posts(@posts)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create_map(current_user, post_params)

    if @post.persisted?
      redirect_to posts_path, success: "掲示板を作成しました。"
    else
      flash.now[:danger] = "掲示板の作成に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    set_map_data

    unless current_user.view_counts.find_by(user_id: current_user.id, post_id: @post.id)
      current_user.view_counts.create(post_id: @post.id)
    end
  end

  def edit
    set_map_data
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), success: "掲示板を更新しました。"
    else
      flash.now[:danger] = "更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, success: "削除しました。"
  end

  private

  def set_post
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to posts_path, alert: "権限がない、もしくは投稿が存在しません。"
    end
  end

  def set_map_data
    @map = @post.map
    gon.latitude = @map.latitude
    gon.longitude = @map.longitude
    gon.marker_image = @map.marker_image
  end

  def post_params
    params.require(:post).permit(
      :temple_name,
      :comment,
      { post_images: [] },
      map_attributes: [ :id, :address, :latitude, :longitude, :marker_image ]
    )
  end
end
