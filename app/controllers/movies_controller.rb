class MoviesController < ApplicationController

    def show
        @movie = Movie.find_by(id: params[:id])
    end
end
