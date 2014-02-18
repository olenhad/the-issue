class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates :name, presence: true, length: {maximum: 50} 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, length: { minimum: 6 }
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.outh_token = auth.credentials.token
      user.outh_expires_at = Time.at(auth.credentials.expires_at)
      password = SecureRandom.uuid
      user.password = password
      user.password_confirmation = password
      user.password_digest = 'secret_digest'
      user.save!
    end
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
