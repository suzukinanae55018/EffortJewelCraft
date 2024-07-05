class CreateDiaryRecordComments < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_record_comments do |t|
      t.integer :user_id, null: false
      t.integer :diary_record_id, null: false
      t.string :comment, null: false
      t.timestamps
    end
  end
end
