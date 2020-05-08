class User < ApplicationRecord

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :shortened_urls

  has_many :visits

  has_many :visited_urls,
           through: :visits,
           source: :shortened_url

end
