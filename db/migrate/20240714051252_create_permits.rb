class CreatePermits < ActiveRecord::Migration[6.1]
  def change
    create_table :permits do |t|
      t.integer :user_id, null: false
      t.integer :group_id, null: false
      t.timestamps
    end
  end
end
