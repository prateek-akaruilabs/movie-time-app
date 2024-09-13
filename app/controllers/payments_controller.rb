class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def new
        p params
        @booking = Booking.find_by(id: params[:booking_id])
        @cinema = @booking.cinema
        @show = @booking.show
        @movie = @show.movie
        @screen = @show.screen
    end

    def create
        booking = Booking.find_by(id: params[:booking_id])
        booking_status = booking.seats_booked.map {|seat_id| Seat.find(seat_id).is_booked?(booking.movie_date, booking.show_id)}

        if booking_status.any? true
            booking.update(
                booking_status: 'Canceled'
            )
            render json: { booking: booking, 
                booking_error: 'seats booked',
                payment: nil
             }, status: 400
        else
            booking.update(
                booking_status: 'Payment Initiated',
            )
            payment = booking.payments.create({
                payment_type: params[:payment_type],
                payment_provider: params[:payment_provider],
                payment_amount: params[:payment_amount],
                payment_status: 'Successful',
                paid_at: Time.zone.now,
                description: nil,
                failure_reason: nil,
                failed_at: nil
            })
            booking.update(
                booking_status: 'Booked',
            ) if payment && payment.payment_status == 'Successful'
            render json: { booking: booking, payment: payment }, status: 200
        end
    end

    def show
        @payment = Payment.find_by(id: params[:id])
        @booking = @payment.booking
        @show = @booking.show
        @screen = @show.screen
        @movie = @booking.show.movie
        @cinema = @booking.cinema
    end
end
