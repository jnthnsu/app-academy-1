require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :short_url, presence: true, uniqueness: true
  validates :user_id, presence: true
  validate :length_less_than_100
  validate :avoid_frequent_submit


  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor

  has_many :taggings,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Tagging

  has_many :tags,
    through: :taggings,
    source: :topic

  def length_less_than_100
    if long_url.length > 100
      self.errors[:long_url] << "is too long"
    end
  end

  def avoid_frequent_submit
    return if submitter.premium
    if submitter.number_of_recent_submits >= 5
      self.errors[:created_at] << "too soon"
    end
  end

  def self.random_code
    random_str = SecureRandom.urlsafe_base64
    while self.exists?(short_url: random_str)
      random_str = SecureRandom.urlsafe_base64
    end
    'http://goo.gl/' + random_str
  end

  def self.create_for_user_and_long_url! user, long_url
    ShortenedUrl.create!(long_url: long_url,
      short_url: self.random_code, user_id: user.id)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    last_ten_sec_visits = visits.where(created_at: 10.minutes.ago..Time.now)
    last_ten_sec_visits.select(:user_id).distinct.count
  end

  def recent_visit? n
    (visits.maximum(:created_at) <=> n.minutes.ago) == 1
  end

  def self.prune n
    self.all.each do |url|
      url.destroy unless url.submitter.premium || url.recent_visit?(n)
    end
    nil
  end
end
