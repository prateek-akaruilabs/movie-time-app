class Seat < ApplicationRecord
  belongs_to :screen

  scope :recliner, -> { where('Lower(category) =?', 'recliner') }
  scope :prime, -> { where('Lower(category) =?', 'prime') }
  scope :normal, -> { where('Lower(category) IN(?)', ['club', 'executive']) }

  def is_booked?(movie_date, show_id)
    Booking.joins(:payments).where("bookings.show_id =? AND bookings.movie_date = ? AND bookings.booking_status =? AND payments.payment_status =?", show_id, Time.zone.now.to_date, 'Booked', 'Successful').pluck(:seats_booked).flatten.include? id
  end

end
