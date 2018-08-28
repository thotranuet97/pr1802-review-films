class User < ApplicationRecord
  has_many :films, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :rated_films, through: :ratings, source: :film, dependent: :destroy
  has_many :reviews, dependent: :destroy

  attr_accessor :remember_token, :reset_token
  before_save :downcase_email

  validates :name, presence: true, length: {minimum: 3}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 50},
    format: {with: VALID_EMAIL_REGEX, message: :email_format},
    uniqueness: {case_sensitive: false}

  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  has_secure_password

  def downcase_email
    self.email = email.downcase
  end

  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update remember_digest: nil
  end

  def set_password_reset_digest
    self.reset_token = User.new_token
    update reset_digest: User.digest(reset_token)
    update reset_sent_at: Time.zone.now
  end

  def send_password_reset
    self.set_password_reset_digest
    UserMailer.password_reset(self).deliver
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end
