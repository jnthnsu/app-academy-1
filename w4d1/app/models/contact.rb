class Contact < ActiveRecord::Base
  validates :name, :email, :user_id, presence: true
  validates_uniqueness_of :email, scope: :user_id

  belongs_to :owner,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :contact_shares
  has_many :shared_users,
    through: :contact_shares,
    source: :user

  has_many :comments, as: :commentable
end
