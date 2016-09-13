require_relative 'questions'

class QuestionFollow
  attr_accessor :user_id, :question_id
  attr_reader :id

  DATABASE = 'question_follows'

  def initialize options
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.followers_for_question_id question_id
    users = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        question_follows
      JOIN users
        ON users.id = question_follows.user_id
      WHERE
        question_id = ?
    SQL

    return nil if users.empty?

    users.map{|datum| User.new(datum)}
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDB.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_follows
      JOIN questions
        ON questions.id = question_follows.question_id
      WHERE
        user_id = ?
    SQL

    return nil if questions.empty?

    questions.map{|datum| Question.new(datum)}
  end

  def self.most_followed_questions n
    questions = QuestionsDB.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        question_follows
      JOIN questions
        ON questions.id = question_follows.question_id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL

    return nil if questions.empty?

    questions.map{|datum| Question.new(datum) }
  end
end
