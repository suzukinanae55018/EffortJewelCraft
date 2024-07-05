class DiaryRecordComment < ApplicationRecord

  validates :comment, presence: true, length:  { maximum: 200 }

  belongs_to :user
  belongs_to :diary_record
end
