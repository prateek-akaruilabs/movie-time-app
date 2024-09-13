class Movie < ApplicationRecord
    has_many :shows
    scope :latest_releases, -> { where(launch_date: [(Time.zone.now - 5.weeks)..(Time.zone.now.utc)]) }

    def release_date
        launch_date.strftime('%b%d, %Y')
    end

    def all_genres
        genre.split('/')
    end
end
