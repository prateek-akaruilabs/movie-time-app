class SeatsController < ApplicationController

    def index
        @cinema = Cinema.find_by(id: params[:cinema_id])
        @show = Show.find_by(id: params[:show_id])
        @screen = @show.screen
        @movie = @show.movie
        @movie_date = params[:date] ? Date.parse(params[:date]) : Date.today
        @upcoming_shows = @cinema.upcoming_shows_of_movie(@movie.id, @movie_date != Date.today)
        @seats = @screen.seats
        @booked_seats = Booking.joins(:payments).where("bookings.show_id =? AND bookings.movie_date = ? AND payments.payment_status =?", @show.id, Time.zone.now.to_date, 'Successful').pluck(:seats_booked).flatten! || []
    end
end