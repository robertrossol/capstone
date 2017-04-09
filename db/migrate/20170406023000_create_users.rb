class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :device_id
      t.integer :blood_sugar_lower
      t.integer :blood_sugar_upper

      t.timestamps
    end
  end
end
