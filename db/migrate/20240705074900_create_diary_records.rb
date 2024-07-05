class CreateDiaryRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_records do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :body, null: false
      t.string :category, null: false
      t.timestamps
    end
  end
end
