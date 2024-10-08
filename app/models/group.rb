class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :introduction, presence: true, length:  { maximum: 300 }
  validates :theme, presence: true, length: { maximum: 100 }
  validates :rule, presence: true, length: { maximum: 100 }

  has_one_attached :group_image

  has_many :group_users, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :permits, dependent: :destroy
  belongs_to :owner, class_name: "User"
  has_many :users, through: :group_users
  # ユーザーはオーナーか確認
  def is_owned_by?(user)
    if owner && owner.id == user.id
      true
    else
      false
    end
  end
  # 与えられたユーザーがグループのユーザーに含まれているか
  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end
  # グループ画像のデフォルトとリサイズ
  def get_group_image(width, height)
    unless group_image.attached?
      file_path = Rails.root.join("app", "assets", "images", "user1.png")
      group_image.attach(io: File.open(file_path), filename: "user1.png", content_type: "image/png")
    end
    group_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @group = Group.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @group = Group.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @group = Group.where("name LIKE?", "%#{word}")
    elsif search == "partial_match"
      @group = Group.where("name LIKE?", "%#{word}%")
    else
      @group = Group.all
    end
  end
end
