class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.integer :bg
      t.integer :user_id

      t.timestamps
    end
  end
end
