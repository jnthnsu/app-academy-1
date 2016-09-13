class Response < ActiveRecord::Base
  validates :user_id, :answer_id, presence: true
  validate :not_duplicate_response
  validate :author_not_respond

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    # respons = Question
    #   .joins(:answer_choices)
    #   .where("answer_choices.id = #{answer_id}")
    #   .joins(answer_choices: :responses)
    #   .where.not("responses.id = #{self.id}")

    Response.select("*")
      .joins(:question)
      .joins(:answer_choices)
      .joins("responses ON answer_choices.id = responses.answer_id")
        .where.not("responses.id = #{self.id}")

    # respons.map{|response| Response.new(user_id: response.user_id, answer_id: response.answer_id)}
  end

  def user_answered?
    question.responses.exists?(user_id: self.user_id)
  end

  def not_duplicate_response
    if user_answered?
      errors[:user] << 'has already answered.'
    end
  end

  def author_not_respond
    if Poll.joins(questions: :answer_choices)
        .where("answer_choices.id = #{answer_id}")
        .first
        .author_id == user_id

      errors[:user] << "can't respond to own poll."
    end
  end
end
