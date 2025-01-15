class Map < ApplicationRecord
  validates :address, presence: true

  belongs_to :post
  geocoded_by :address
  after_validation :geocode
  def self.ransackable_attributes(auth_object = nil)
    [ "address", "created_at", "id", "latitude", "longitude", "marker_image", "post_id", "updated_at" ]
  end
end
