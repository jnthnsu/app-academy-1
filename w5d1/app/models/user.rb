class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}
  has_many :comments, as: :commentable

  attr_reader :password

  after_initialize :ensure_session_token

  def self.find_by_credentials username, password
    user = User.find_by_username(username)
    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

  def is_password? password
    BCrypt::Password.new(self.password_digest) == password
  end

  def password= password
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
