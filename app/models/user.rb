class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  attr_accessor :remember_token, :reset_token

  has_many :films, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :rated_films, through: :ratings, source: :film, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates_presence_of :email
  validates_length_of :email,
    maximum: Settings.user.email.length.maximum,
    allow_blank: true
  validates_format_of :email, with: VALID_EMAIL_REGEX, message: :email_format,
    allow_blank: true
  validates_uniqueness_of :email, case_sensitive: false,
    allow_blank: true

  validates_presence_of :name
  validates_length_of :name,
    minimum: Settings.user.name.length.minimum,
    allow_blank: true

  validates_length_of :password,
    minimum: Settings.user.password.length.minimum,
    allow_nil: true

  has_secure_password

  before_save :downcase_email

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
