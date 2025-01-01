class RemoveLocationFromPosts < ActiveRecord::Migration[7.2]
  def change
    remove_column :posts, :location, :string
  end
end
