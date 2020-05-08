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
    visits.size
  end

  def num_uniques
    visitors.size
  end

  def num_recent_uniques
    visitors.where(created_at: 10.minutes.ago..Time.current).size
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
