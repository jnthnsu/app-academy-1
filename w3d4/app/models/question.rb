class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :responses,
    through: :answer_choices,
    source: :responses


  def self.add_question(poll, text)
    Question.create!(poll_id: poll.id, text: text)
  end

  def add_choice(text)
    AnswerChoice.create!(question_id: self.id, text: text)
  end

  def response
    answer_choices
      .joins("LEFT OUTER JOIN responses AS r
        ON answer_choices.id = r.answer_id")
      .group("answer_choices.text")
      .count
  end

  def better_responses

    response_tally = AnswerChoice.find_by_sql(<<-SQL)
      SELECT
        ac.text, COUNT(r.id) AS count_response
      FROM
        answer_choices AS ac
      LEFT OUTER JOIN responses AS r
        ON ac.id = r.answer_id
      WHERE
        ac.question_id = #{self.id}
      GROUP BY
        ac.id
    SQL

    responses = {}
    response_tally.each { |response| responses[response.text] = response.count_response }
    responses
  end

  def question_set
    poll.questions
  end

end
