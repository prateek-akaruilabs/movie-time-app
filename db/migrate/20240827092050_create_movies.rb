class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :genre
      t.string :language
      t.string :industry
      t.text :description
      t.integer :length
      t.float :rating
      t.string :age_category
      t.datetime :launch_date
      t.text :image_url

      t.timestamps
    end
  end
end
