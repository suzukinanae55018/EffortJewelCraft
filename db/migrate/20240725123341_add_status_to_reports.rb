class AddStatusToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :status, :integer, default: 0, null: false
  end
end
