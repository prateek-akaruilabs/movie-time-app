class ShowsController < ApplicationController
  
  def index
    @movie = Movie.find_by(id: params[:movie_id])
    @cinemas = Cinema.joins(screens: :shows).where('shows.movie_id =?', @movie.id).uniq
    @calendar_days = (Date.today..(Date.today + 5.days))
    @movie_date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
