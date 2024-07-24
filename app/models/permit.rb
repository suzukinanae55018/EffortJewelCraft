class Permit < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_one :notification, as: :notifiable, dependent: :destroy

   after_create do
    create_notification(user_id: group.owner.id)
  end

end
