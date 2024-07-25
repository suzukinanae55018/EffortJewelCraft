class Report < ApplicationRecord
  belongs_to :user
  belongs_to :diary_record

  validates :report, presence: true, length: { maximum: 100 }
end
