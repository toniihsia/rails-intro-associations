class Visit < ActiveRecord::Base
  validates :user_id, presence: true
  validates :short_url, presence: true

  def self.record_visit!(user_id, shortened_url)
    Visit.create!(user_id: user_id, short_url: shortened_url)
  end

  # belongs_to(
  #   :visitor,
  #   primary_key: :id,
  #   foreign_key: :user_name,
  #   class_name: :User
  # )

  has_many(
    :visitors,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
  )

end
