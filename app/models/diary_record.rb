class DiaryRecord < ApplicationRecord

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length:  { maximum: 300 }
  validates :category, presence: true,length: { maximum: 50 }

  has_one_attached :diary_record_image
  has_one_attached :background_image

  belongs_to :user
  has_many :diary_record_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  # いいねをしたユーザーを取得できる↑
end
