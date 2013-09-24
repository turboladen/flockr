class User < ActiveRecord::Base
  before_save do
    self.email = email.downcase
    self.username = username.downcase
  end

  before_create :create_remember_token

  has_many :photos, dependent: :destroy
  has_many :comments
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
