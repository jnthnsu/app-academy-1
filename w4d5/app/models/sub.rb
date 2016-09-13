class Sub < ActiveRecord::Base
  include Authorable
  validates :title, :description, :user_id, presence: true

  belongs_to :user
  has_many :post_subs, inverse_of: :sub, dependent: :destroy
  has_many :posts,
    through: :post_subs,
    source: :post
end
