class Track < ActiveRecord::Base
  belongs_to :album
  has_one :band,
    through: :album
  has_many :notes,
    dependent: :destroy

  validates :name, :album_id, :bonus, presence: true
end
