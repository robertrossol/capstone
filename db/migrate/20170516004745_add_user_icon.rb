class AddUserIcon < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :icon, :string, default: "smily.png"
  end
end
