class Group < ApplicationRecord

  validates :name, presence: true, length: { maximum: 20 }
  validates :introduction, presence: true, length:  { maximum: 300 }

  has_one_attached :group_image

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy
end
