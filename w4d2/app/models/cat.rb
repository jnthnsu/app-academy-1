class Cat < ActiveRecord::Base
  COLORS = 'roygbiv'.chars

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :sex, inclusion: {in: ['M', 'F']}
  validates :color, inclusion: {in: COLORS}

  has_many :cat_rental_requests, dependent: :destroy

  def age
    Time.now.year - self.birth_date.year
  end
end
