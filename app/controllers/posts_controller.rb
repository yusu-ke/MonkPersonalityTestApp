class PostsController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: false).includes(:user, :view_counts).order(created_at: :desc).all.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    logger.debug "Params: #{params[:post][:map_attributes]}"
    if @post.save
      if params[:post][:map_attributes].present?
        latitude = params[:post][:map_attributes][:latitude]
        longitude = params[:post][:map_attributes][:longitude]
        unless latitude.empty? && longitude.empty?
          @map = @post.build_map(
            latitude: latitude,
            longitude: longitude
          )
          @map.save
        end
      end

      redirect_to posts_path, success: "掲示板を作成しました。"
    else
      flash.now[:danger] = "掲示板の作成に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @map = @post.map
    unless current_user.view_counts.find_by(user_id: current_user.id, post_id: @post.id)
      current_user.view_counts.create(post_id: @post.id)
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), success: "掲示板を更新しました。"
    else
      flash.now[:danger] = "更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, success: "削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(
      :temple_name,
      :location,
      :comment,
      { post_images: [] },
      map_attributes: [:id, :latitude, :longitude]
      )
  end
end
