class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credentials username, password
    @user = User.find_by_username(username)
    return @user if @user.nil?

    @user.is_password?(password) ? @user : nil
  end

  def password= password
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password? password
    BCrypt::Password.new(self.password_digest) == password
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
