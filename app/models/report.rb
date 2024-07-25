class Report < ApplicationRecord
  belongs_to :user
  belongs_to :diary_record

  validates :report, length: { maximum: 200 }
end
