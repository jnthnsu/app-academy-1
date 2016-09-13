class User < ActiveRecord::Base
  validates :nickname, :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :todo_lists
  has_many :todo_items, through: :todo_lists, source: :items

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials nickname, password
    user = User.find_by_nickname(nickname)
    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def is_password? password
    BCrypt::Password.new(self.password_digest) == password
  end

  def password= password
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end
end
