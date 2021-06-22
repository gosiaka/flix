class Movie < ApplicationRecord

  def flop?
    self.total_gross.blank? || self.total_gross < 225000000
  end

  def self.released
    where("released_on < ?", Time.now ).order(released_on: :desc)
  end

  # def self.hit_movies
  #   where("total_gross >= 300000000").order(total_gross: :desc)
  # end

  # def self.flop_movies
  #   where("total_gross < 225000000").order(total_gross: :asc)
  # end

  # def self.recently_added_movies
  #   order(created_at: :desc).limit(3)
  # end
end

#  hit movies: movies with at least $300M total gross, ordered with the highest grossing movie first
# flop movies: movies with less than $225M total gross, ordered with the lowest grossing movie first
# recently added movies: the last three movies that have been created, ordered with the most recently-added movie first. Hint: you need to limit the result to 3 records.