class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :poster
      t.integer :tmdb_id

      t.timestamps
    end
      add_index :movies, :tmdb_id, :unique => true
  end
end
