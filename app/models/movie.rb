class Movie < ApplicationRecord

  def flop?
    self.total_gross.blank? || self.total_gross < 225000000
  end

end
