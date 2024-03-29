class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many :notes,
    dependent: :destroy
    
  attr_reader :password

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    save!
    self.session_token
  end

  def password= password
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password? password
    BCrypt::Password.new(self.password_digest) == password
  end

  def self.find_by_credentials email, password
    user = User.find_by_email(email)
    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end
end
