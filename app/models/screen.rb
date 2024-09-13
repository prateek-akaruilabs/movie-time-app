class Screen < ApplicationRecord
  belongs_to :cinema
  has_many :shows
  has_many :seats

  def seat_categories
    seats.pluck(:category).uniq
  end

  def seat_with_price
    seats.pluck(:category, :price).uniq.map {|a, b| "#{a} (Rs. #{ActionController::Base.helpers.number_with_precision(b, :precision => 2)})"}.join("<br>")
  end
end
