module MoviesHelper
  def total_gross(movie)
    if movie.flop? #bez movie też działało why?
      "Flop!!!!!"
    else
      number_to_currency(movie.total_gross, precision: 0)
    end
  end
end
