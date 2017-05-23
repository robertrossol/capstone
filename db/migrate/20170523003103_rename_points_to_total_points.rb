class RenamePointsToTotalPoints < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :points, :totalpoints
  end
end
