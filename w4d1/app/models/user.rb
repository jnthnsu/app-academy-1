class User < ActiveRecord::Base
  validates :username, presence: true

  has_many :contacts,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Contact

  has_many :contact_shares,
    dependent: :destroy
  has_many :shared_contacts,
    through: :contact_shares,
    source: :contact

  has_many :comments, as: :commentable
end
