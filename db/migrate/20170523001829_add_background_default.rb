class AddBackgroundDefault < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :background, :string, :default => '/backgrounds/01.jpg'
  end
end
