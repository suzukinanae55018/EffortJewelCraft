class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :user_id, null: false
      t.integer :diary_record_id, null: false
      t.text :report, null: false

      t.timestamps
    end
  end
end
