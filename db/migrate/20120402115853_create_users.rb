class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :avatar
      t.string :facebook_id
      t.string :facebook_token

      t.timestamps
    end
    add_index :users, :facebook_id, :unique => true
  end
end
