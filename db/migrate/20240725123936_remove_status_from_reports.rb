class RemoveStatusFromReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :status, :integer
  end
end
