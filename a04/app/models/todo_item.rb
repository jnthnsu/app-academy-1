class TodoItem < ActiveRecord::Base
  validates :body, :todo_list, presence: true

  belongs_to :todo_list
  has_one :user, through: :todo_list
end
