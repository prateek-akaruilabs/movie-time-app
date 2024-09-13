class HomeController < ApplicationController

    def index
        @recommended_movies = Movie.latest_releases
    end
end
