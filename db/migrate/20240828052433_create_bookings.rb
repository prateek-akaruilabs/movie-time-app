class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.string :booking_id
      t.decimal :total_seat_charges
      t.decimal :total_convenience_charges
      t.decimal :food_and_beverage_charges 
      t.decimal :total_amount 
      t.string :ticket_type 
      t.json :food_and_beverage_details
      t.json :seat_details
      t.date :movie_date
      t.json :seats_booked, default: []
      t.string :booking_status
      t.references :user, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
