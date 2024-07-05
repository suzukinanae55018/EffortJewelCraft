class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 100 }

  has_one_attached :user_image

  has_many :diary_records, dependent: :destroy
  has_many :diary_record_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_diary_records, through: :favorites, source: :diary_record
  # お気に入りをした投稿を取得できる↑
  #中間テーブルの記述↓
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

end
