class Visit < ApplicationRecord

  validates :user_id, :shortened_url_id, presence: true

  belongs_to :shortened_url

  belongs_to :user

  # @param [User] user
  # @param [ShortenedUrl] url
  def self.record_visit!(user, url)
    visit = Visit.new(
      user_id: user.id,
      shortened_url_id: url.id
    )
    visit if visit.save
  end

end
