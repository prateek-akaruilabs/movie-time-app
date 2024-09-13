class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :screen
  has_many :bookings
  
  def is_available?(selected_date)
    # if not all the seats have been booked 
    total_seats == 0 || !is_filling_fast?(selected_date)
  end

  def is_filling_fast?(selected_date)
    # if more than 50% seats have been booked 
    bookings_of_show_on_date = bookings_of_show_on_date(selected_date)
    (total_booked_seats(bookings_of_show_on_date) / total_seats) > 0.5
  end

  def is_almost_full?(selected_date)
    # if more than 90% seats have been booked 
    bookings_of_show_on_date = bookings_of_show_on_date(selected_date)
    (total_booked_seats(bookings_of_show_on_date) / total_seats) > 0.9
  end

  def is_sold_out?(selected_date)
    # if all the seats have been booked 
    bookings_of_show_on_date = bookings_of_show_on_date(selected_date)
    (total_booked_seats(bookings_of_show_on_date) / total_seats) == 1.0
  end

  private 

  def total_seats
    screen.seats.count.to_f
  end

  def bookings_of_show_on_date(selected_date) 
    bookings.where(movie_date: selected_date, booking_status: 'Booked')
  end

  def total_booked_seats(all_bookings)
    all_bookings.pluck(:seats_booked).flatten.count
  end

end
