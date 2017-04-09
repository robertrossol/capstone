class DefaultLevel < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :level, :level, default: 1
  end
end
