class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks,
    dependent: :destroy

  validates :title, :band_id, :live, presence: true
end
