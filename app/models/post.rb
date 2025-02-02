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

  scope :latest, -> { order(created_at: :desc).limit(10) }
  scope :old, -> { order(created_at: :asc).limit(10) }

  def self.ransackable_attributes(auth_object = nil)
    [ "comment", "created_at", "id", "post_images", "temple_name", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user", "view_counts", "map" ]
  end

  def self.create_map(user,post_params)
    post = user.posts.build(post_params)

    if post.save && post_params[:map_attributes].present?
      latitude = post_params[:map_attributes][:latitude]
      longitude = post_params[:map_attributes][:longitude]
      marker_image = post_params[:map_attributes][:marker_image]

      unless latitude.blank? || longitude.blank?
        post.create_map(
          address: post_params[:map_attributes][:address],
          latitude: latitude,
          longitude: longitude,
          marker_image: marker_image
        )
      end
    end
    post
  end

  private

  def validate_image_coutn
    if post_images.count > 3
      errors.add(:post_images, "は3枚以下にしてください。")
    end
  end
end
