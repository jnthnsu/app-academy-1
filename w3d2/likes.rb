require_relative 'questions'

class QuestionLike
  attr_accessor :user_id, :question_id
  attr_reader :id

  DATABASE = 'question_likes'

  def initialize options
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.likers_for_question_id question_id
    users = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes
      JOIN users
        ON users.id = question_likes.user_id
      WHERE
        question_id = ?
    SQL

    return nil if users.empty?

    users.map{|datum| User.new(datum)}
  end

  def self.num_likes_for_question_id question_id
    QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL
  end

  def self.liked_questions_for_user_id user_id
    questions = QuestionsDB.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_likes
      JOIN questions
        ON questions.id = question_likes.question_id
      WHERE
        user_id = ?
    SQL

    return nil if questions.empty?

    questions.map{|datum| Question.new(datum)}
  end

  def self.most_liked_questions n
    questions = QuestionsDB.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        question_likes
      JOIN questions
        ON questions.id = question_likes.question_id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL

    return nil if questions.empty?

    questions.map{|datum| Question.new(datum)}
  end
end
