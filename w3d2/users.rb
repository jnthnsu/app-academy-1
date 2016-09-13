require_relative 'questions'

class User < ModelBase
  attr_accessor :fname, :lname
  attr_reader :id, :database

  DATABASE = 'users'

  def initialize options
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_name fname, lname
    user = QuestionsDB.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    return nil if user.empty?

    User.new(user.first)
  end

  def authored_questions
    Question.find_by_author_id @id
  end

  def authored_replies
    Reply.find_by_user_id @id
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id @id
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id @id
  end

  def average_karma
    karma = QuestionsDB.instance.execute(<<-SQL, @id)
      SELECT
        COUNT(DISTINCT(questions.id)) / CAST(COUNT(*) AS FLOAT)
      FROM
        question_likes
      JOIN
        questions ON questions.id = question_likes.question_id
      WHERE
        questions.author_id = ?
    SQL

    karma = karma.first.values.first

    return 0 if karma.nil?
    karma
  end
end
