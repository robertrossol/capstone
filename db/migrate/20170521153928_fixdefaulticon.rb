class Fixdefaulticon < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :icon, "/images/smily.png"
  end
end
