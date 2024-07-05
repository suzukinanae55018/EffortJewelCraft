class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :encrypted_password, presence: true, length: { minimum: 8, maximum: 50 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 100 }
　validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 100 }

　has_one_attached :user_image

  has_many :diary_records, dependent: :destroy
  has_many :diary_record_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_diary_records, through: :favorites, source: :diary_record
　# 、お気に入りをした投稿を取得できる↑
　#中間テーブルの記述↓
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy
end
