require 'sqlite3'
require 'singleton'

require_relative 'modelbase'

require_relative 'users'
require_relative 'replies'
require_relative 'follows'
require_relative 'likes'


class QuestionsDB < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question < ModelBase
  attr_accessor :title, :body, :author_id
  attr_reader :id

  DATABASE = 'questions'

  def initialize options
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def self.find_by_author_id author_id
    questions = QuestionsDB.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    return nil if questions.empty?

    questions.map{|datum| Questions.new(datum)}
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id @id
  end

  def self.most_followed n
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id @id
  end

  def num_likes
    QuestionLike.num_likes_for_question_id @id
  end

  def self.most_liked n
    QuestionLike.most_liked_questions(n)
  end
end
