class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :title
      t.text :overview
	  t.text :description
	  t.string :rating
      t.datetime :released_on
	  t.string :genre
	  t.string :scores

      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
