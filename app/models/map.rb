class Map < ApplicationRecord
  validates :address, presence: true

  belongs_to :post
  geocoded_by :address
  after_validation :geocode
  def self.ransackable_attributes(auth_object = nil)
    [ "address", "created_at", "id", "latitude", "longitude", "marker_image", "post_id", "updated_at" ]
  end

  def self.locations_posts(posts)
    locations = Map.joins(:post).where(posts: { id: posts.pluck(:id) })
    locations.map do |location|
      {
        latitude: location.latitude,
        longitude: location.longitude,
        address: location.address,
        marker_image: location.marker_image,
        link: Rails.application.routes.url_helpers.post_path(location.post_id)
      }
    end
  end
end
