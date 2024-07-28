class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_one :notification, as: :notifiable, dependent: :destroy
# グループ参加承認後、承認されたユーザーに通知
  after_create do
    create_notification(user_id: user_id)
  end
end
