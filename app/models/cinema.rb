class Cinema < ApplicationRecord
    has_many :screens
    has_many :snacks

    def all_shows
        Show.where(screen_id: screens).sort
    end

    def upcoming_shows
        all_shows.filter { |show| Time.parse(show.show_time) > Time.now }
    end

    def upcoming_shows_of_movie(movie_id, booking_for_another_date)
        booking_for_another_date ? all_shows : upcoming_shows.filter {|show| show.movie_id == movie_id }
    end

end
