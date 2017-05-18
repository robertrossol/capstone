class AddBackgroundtoUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :background, :string
  end
end
