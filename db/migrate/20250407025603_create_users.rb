class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end