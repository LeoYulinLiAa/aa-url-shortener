class ShortenedUrl < ApplicationRecord

  validates :user_id, presence: true
  validates :long_url, presence: true

  belongs_to :user

  has_many :visits

  has_many :visitors,
           proc { distinct },
           through: :visits,
           source: :user

  def num_clicks
    Visit.where(shortened_url_id: id).count
  end

  def num_uniques
    Visit.where(shortened_url_id: id).count('DISTINCT user_id')
  end

  def num_recent_uniques
    Visit.where(shortened_url_id: id, created_at: 10.minutes.ago..Time.current)
         .count('DISTINCT user_id')
  end

  def self.random_code
    SecureRandom.urlsafe_base64(16)
  end

  # @param [User] user
  # @param [String] long_url
  def self.create!(user, long_url)
    code = random_code
    code = random_code while exists?(short_url: code)
    new = ShortenedUrl.new(user_id: user.id, long_url: long_url, short_url: random_code)
    new if new.save
  end

end
