class Goal < ActiveRecord::Base
  validates :title, :details, presence: true
  has_many :comments, as: :commentable
end
