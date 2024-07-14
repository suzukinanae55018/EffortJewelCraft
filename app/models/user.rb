class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 100 }

  has_one_attached :profile_image

  has_many :diary_records, dependent: :destroy
  has_many :diary_record_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_diary_records, through: :favorites, source: :diary_record
  # お気に入りをした投稿を取得できる↑
  #中間テーブルの記述↓
  has_many :group_users, dependent: :destroy
  has_many   :permits,          dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app","assets","images","user1.png")
      profile_image.attach(io: File.open(file_path), filename: "user1.png", content_type: "image/png")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
