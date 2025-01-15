class Post < ApplicationRecord
  validates :temple_name, presence: true, length: { maximum: 20 }
  validates :comment, presence: true, length: { maximum: 255 }
  validates :post_images, presence: { message: I18n.t("activerecord.errors.messages.post_images_blank") }
  validate :validate_image_coutn

  mount_uploaders :post_images, PostImageUploader
  belongs_to :user
  has_many :view_counts, dependent: :destroy
  has_one :map, dependent: :destroy
  accepts_nested_attributes_for :map

  def self.ransackable_attributes(auth_object = nil)
    [ "comment", "created_at", "id", "location", "post_images", "temple_name", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user", "view_counts", "map" ]
  end

  private

  def validate_image_coutn
    if post_images.count > 3
      errors.add(:post_images, "は3枚以下にしてください。")
    end
  end
end
