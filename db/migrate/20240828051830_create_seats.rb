class CreateSeats < ActiveRecord::Migration[7.1]
  def change
    create_table :seats do |t|
      t.integer :number
      t.string :row
      t.string :category
      t.decimal :price
      t.references :screen, null: false, foreign_key: true

      t.timestamps
    end
  end
end
