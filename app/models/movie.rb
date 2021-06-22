class Movie < ApplicationRecord

  def flop?
    self.total_gross.blank? || self.total_gross < 225000000
  end

  def self.released
    where("released_on < ?", Time.now ).order(released_on: :desc)
  end
end
