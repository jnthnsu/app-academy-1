class TodoList < ActiveRecord::Base
  validates :name, :description, :user, presence: true

  belongs_to :user
  has_many :items,
    primary_key: :id,
    foreign_key: :todo_list_id,
    class_name: :TodoItem
end
