class Post < ApplicationRecord
  validates :temple_name, presence: true, length: { maximum: 20 }
  validates :location, presence: true, length: { maximum: 20 }
  validates :comment, presence: true, length: { maximum: 255 }
  validate :validate_image_coutn

  mount_uploaders :post_images, PostImageUploader
  belongs_to :user
  has_many :view_counts, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["comment", "created_at", "id", "location", "post_images", "temple_name", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "view_counts"]
  end

  private

  def validate_image_coutn
    if post_images.count > 5
      errors.add(:post_images, "は5枚以下にしてください。")
    end
  end
end
