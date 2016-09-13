class ContactShare < ActiveRecord::Base
  validates :contact_id, :user_id, presence: true
  validates_uniqueness_of :contact_id, scope: :user_id

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :contact,
    primary_key: :id,
    foreign_key: :contact_id,
    class_name: :Contact


end
