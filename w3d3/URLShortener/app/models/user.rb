class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, null: false

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

  has_many :visits,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Visit

  has_many :visited_urls,
    -> { distinct },
    through: :visits,
    source: :url

  def number_of_recent_submits
    submitted_urls.where(created_at: 1.minute.ago..Time.now).count
  end
end
