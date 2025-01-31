class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: { general: 0, admin: 1 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  validates :name, presence: true, length: { maximum: 50 }
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }
  has_many :posts, dependent: :destroy
  has_many :view_counts, dependent: :destroy
end
