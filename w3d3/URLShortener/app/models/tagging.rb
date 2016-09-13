class Tagging < ActiveRecord::Base

  validates :url_id, :topic_id, presence: true
  validates_uniqueness_of :url_id, scope: :topic_id

  belongs_to :url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedUrl

  belongs_to :topic,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :TagTopic

  def self.create_tagged_url(topic, url)
    Tagging.create!(topic_id: topic.id, url_id: url.id)
  end

end
