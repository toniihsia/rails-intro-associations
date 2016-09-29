class ShortenedUrl < ActiveRecord::Base
  include SecureRandom

  validates :long_url, presence: true, uniqueness: true
  validates :short_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  has_many(
    :visitors,
    primary_key: :short_url,
    foreign_key: :short_url,
    class_name: :Visit
  )

  belongs_to(
    :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
  )

  def self.random_code
    shortened_url = SecureRandom.base64(16)
    until !self.exists?(short_url: shortened_url)
      shortened_url = SecureRandom.base64(16)
    end
    shortened_url
  end

  def self.create_for_user_and_long_url!(user_id, long_url)
    self.create!(long_url: long_url, short_url: self.random_code, user_id: user_id)
  end

  def num_clicks
    self.visitors.count
  end

  def num_uniques
    self.visitors.select(:user_id).distinct.count
  end

  def num_recent_uniques
    self.visitors.where(created_at: (10.minutes.ago)..Time.now).select(:user_id).distinct.count
  end



end
