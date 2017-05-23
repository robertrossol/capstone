class DeleteTotalPoints < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :totalpoints, :integer
  end
end
