class Note < ActiveRecord::Base
  validates :body, :user_id, :track_id, presence: true
  validates_uniqueness_of :user_id, scope: :track_id

  belongs_to :user
  belongs_to :track
end
