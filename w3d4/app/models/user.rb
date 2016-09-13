class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

    def make_poll(title)
      Poll.create!(author_id: self.id, title: title)
    end

    def respond(answer)
      Response.create!(answer_id: answer.id, user_id: self.id)
    end

    def completed_polls
      Poll.find_by_sql(<<-SQL)
        SELECT
          polls.*
        FROM
          polls
        JOIN questions
          ON polls.id = questions.poll_id
        JOIN answer_choices as answers
          ON questions.id = answers.question_id
        LEFT JOIN (
          SELECT
            *
          FROM
            responses
          WHERE
            responses.user_id = #{self.id}
        ) AS our_responses
          ON our_responses.answer_id = answers.id
        GROUP BY
          polls.id
        HAVING
          COUNT(our_responses.id) = COUNT(DISTINCT questions.id)
      SQL
    end
end
