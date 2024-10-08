class DiaryRecord < ApplicationRecord
  validates :title, presence: true, length: { maximum: 45 }
  validates :body, presence: true, length:  { maximum: 300 }
  validates :category, presence: true, length: { maximum: 40 }

  has_one_attached :diary_record_image
  has_one_attached :background_image

  belongs_to :user
  has_many :reports, dependent: :destroy
  has_many :diary_record_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  # いいねをしたユーザーを取得できる↑
  # ユーザーがいいねしたかどうか、ユーザーが存在しなければfalse
  def favorited_by?(user)
    if user.present?
      favorites.exists?(user_id: user.id)
    else
      false
    end
  end
  # 投稿画像のデフォルトとリサイズ
  def get_diary_record_image(width, height)
    unless diary_record_image.attached?
      file_path = Rails.root.join("app", "assets", "images", "touka.png")
      diary_record_image.attach(io: File.open(file_path), filename: "touka.png", content_type: "image/png")
    end
    diary_record_image.variant(resize_to_limit: [width, height]).processed
  end
  # 背景画像のデフォルトとリサイズ
  def get_background_image(width, height)
    unless background_image.attached?
      file_path = Rails.root.join("app", "assets", "images", "touka.png")
      background_image.attach(io: File.open(file_path), filename: "touka.png", content_type: "touka.png")
    end
    background_image.variant(resize_to_limit: [width, height]).processed
  end
  # 投稿検索用
  def self.looks(search, word)
    if search == "perfect_match"
      @diary_record = DiaryRecord.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @diary_record = DiaryRecord.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @diary_record = DiaryRecord.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @diary_record = DiaryRecord.where("title LIKE?", "%#{word}%")
    else
      @diary_record = DiaryRecord.all
    end
  end
end
