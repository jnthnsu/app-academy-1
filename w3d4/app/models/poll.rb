class Poll < ActiveRecord::Base
  validates :author_id, presence: true
  validates :title, presence: true, uniqueness: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  has_many :questions,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Question

    def add_question(text)
      Question.create!(poll_id: self.id, text: text)
    end
end
