class ChangePostToJson < ActiveRecord::Migration[7.2]
  def change
    change_column :posts, :post_image, :json, default: [], using: 'post_image::json'
  end
end
