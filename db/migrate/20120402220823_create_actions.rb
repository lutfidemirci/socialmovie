class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :name
      t.references :user
      t.references :movie
      t.string :fbid

      t.timestamps
    end
    add_index :actions, :user_id
    add_index :actions, :movie_id
  end
end
