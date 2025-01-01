class Map < ApplicationRecord
  validates :address, presence: true
  
  belongs_to :post
  geocoded_by :address
  after_validation :geocode
end
