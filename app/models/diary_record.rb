class DiaryRecord < ApplicationRecord

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length:  { maximum: 200 }
  validates :category, presence: true,length: { maximum: 50 }

  has_one_attached :diary_record_image
  has_one_attached :background_image

  belongs_to :user
  has_many :diary_record_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  # いいねをしたユーザーを取得できる↑
  
  def get_diary_record_image(width, height)
    unless diary_record_image.attached?
      file_path = Rails.root.join("app/assets/images/touka.png")
      diary_record_image.attach(io: File.open(file_path), filename: "touka.png", content_type: "image/png")
    end
    diary_record_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # 後で背景を選べるようにする
  def get_background_image(width, height)
    unless background_image.attached?
      file_path = Rails.root.join("app/assets/images/touka.png")
      background_image.attach(io: File.open(file_path), filename: "touka.png", content_type: "touka.png")
    end
    background_image.variant(resize_to_limit: [width, height]).processed
  end
end
