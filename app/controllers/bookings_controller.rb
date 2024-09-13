class BookingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @cinema = Cinema.find_by(id: params[:cinema_id])
    @snacks = @cinema.snacks
    @screen = @cinema.screens.find_by(id: params[:screen_id])
    @show = @screen.shows.find_by(id: params[:show_id])
    @movie = @show.movie
    @recommended_movies = Movie.latest_releases
  end

  def create
    seats_selected = JSON.parse(params[:seats_selected])
    selected_seat_ids = seats_selected.pluck('id')
    p selected_seat_ids
    bookings = selected_seat_ids.map {|seat_id| Seat.find(seat_id).is_booked?(params[:movie_date], params[:show_id])}
    p bookings

    if bookings.any? true
      render json: { booking: nil, booking_error: 'seats booked' }, status: 400 
    else
      booking = Booking.create({
        total_seat_charges: params[:total_seat_price],
        total_convenience_charges: params[:convenience_fee],
        food_and_beverage_charges: params[:total_snacks_price],
        total_amount: params[:final_price_to_pay],
        ticket_type: params[:ticket_type],
        food_and_beverage_details: JSON.parse(params[:snacks_selected]),
        seat_details: seats_selected,
        movie_date: params[:movie_date],
        user_id: @user_id || 1,
        show_id: params[:show_id],
        seats_booked: selected_seat_ids,
        booking_status: 'Awaited Payment'
      })
      render json: { booking: booking }, status: 200
    end    
  end

  def show
    @booking = Booking.find_by(id: params[:id])
  end
end
