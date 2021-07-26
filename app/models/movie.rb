class Movie < ApplicationRecord

  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations
  
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :reviews, dependent: :destroy
  # self.has_many(:reviews, { dependent: :destroy }) # explicit
  
  RATINGS = %w(G PG PG-13 R NC-17)

  validates :title, :released_on, :duration, :director, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }
  validates :rating, inclusion: { in: RATINGS }

  # Change the definition of the flop? method so that cult classics aren’t included. For example, if a movie has more than 50 reviews and the average review is 4 stars or better, then the movie shouldn’t be a flop regardless of the total gross.

  def flop?
    if reviews.size > 50 && reviews.average(:stars) >= 4
      false
    else
      self.total_gross.blank? || self.total_gross < 225000000
    end
  end

  scope :released, -> {where("released_on < ?", Time.now ).order(released_on: :desc)}
  scope :upcoming, -> {where("released_on > ?", Time.now ).order(released_on: :asc)}

  # scope :recent, lambda { |max=4| released.limit(max) }    or:
  scope :recent, -> (max = 4) { released.limit(max) }

  scope :hits, -> { released.where("total_gross >= 300000000").order(total_gross: :desc)}
  scope :flops, -> { released.where("total_gross < 225000000").order(total_gross: :asc) }

  def average_stars
    self.reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (average_stars / 5.0) * 100.0
  end
end
