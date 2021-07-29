class User < ApplicationRecord

  before_save :set_slug

  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  has_many :reviews, dependent: :destroy
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true,
                        uniqueness: { case_sensitive: false }
  validates :email, presence: true,
                    format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8, allow_blank: true}


  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def to_param
    slug
  end

  private

 def set_slug
    self.slug = username.parameterize
  end
end
