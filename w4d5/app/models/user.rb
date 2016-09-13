class User < ActiveRecord::Base
  validates :name, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  has_many :subs
  has_many :posts
  has_many :comments

  attr_reader :password

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password= password
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def is_password? password
    BCrypt::Password.new(self.password_digest) == password
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials name, password
    user = User.find_by(name: name)
    return nil if user.nil?

    return nil unless user.is_password?(password)
    user
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
