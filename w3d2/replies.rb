require_relative 'questions'

class Reply < ModelBase
  attr_accessor :question_id, :body, :author_id, :parent_id
  attr_reader :id

  DATABASE = 'replies'

  def initialize options
    @id = options['id']
    @question_id = options['question_id']
    @body = options['body']
    @author_id = options['author_id']
    @parent_id = options['parent_id']
  end

  def self.find_by_user_id user_id
    replies = QuestionsDB.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    return nil if replies.empty?

    replies.map{|datum| Reply.new(datum)}
  end

  def self.find_by_question_id question_id
    replies = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    return nil if replies.empty?

    replies.map{|datum| Reply.new(datum)}
  end

  def author
    User.find_by_id @author_id
  end

  def question
    Question.find_by_id @question_id
  end

  def parent_reply
    Reply.find_by_id @parent_id
  end

  def child_replies
    child =  QuestionsDB.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    return nil if child.empty?

    child.map{|datum| Reply.new(datum)}
  end
end
