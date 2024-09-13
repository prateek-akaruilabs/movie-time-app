class CreateSnacks < ActiveRecord::Migration[7.1]
  def change
    create_table :snacks do |t|
      t.string :name
      t.decimal :price, precision: 5, scale: 2
      t.string :food_type
      t.string :category
      t.boolean :in_stock
      t.float :discount_perc
      t.text :image_url
      t.references :cinema, null: false, foreign_key: true
      t.timestamps
    end
  end
end

# (1..10).each do |n|
#   Snack.create({
#     name: "Combo #{n}",
#     price: 50 * n,
#     food_type: 'Veg',
#     category: 'Food & Beverage',
#     in_stock: true,
#     discount_perc: 0,
#     image_url: '/images/snacks/snack.avif',
#     cinema_id: 1
#   }]
