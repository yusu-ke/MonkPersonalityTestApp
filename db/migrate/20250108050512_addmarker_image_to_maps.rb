class AddmarkerImageToMaps < ActiveRecord::Migration[7.2]
  def change
    add_column :maps, :marker_image, :string
  end
end
