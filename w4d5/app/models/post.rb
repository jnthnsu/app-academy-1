class Post < ActiveRecord::Base
  include Authorable
  validates :title, :user_id, presence: true

  belongs_to :user
  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :subs,
    through: :post_subs,
    source: :sub
  has_many :comments
end
