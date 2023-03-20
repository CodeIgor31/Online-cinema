# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :old_password

  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9.]+@[a-z]{2,6}\.[a-z]{2,3}\z/,
  message: 'Не верный формат' }
  validates :login, presence: true
  validates :phone, presence: true, uniqueness: true, format: { with: /\A\+7\d{10}\z/,
  message: 'Начинается с +7 и только цифры(10 штук)' }

  validate :password_presence
  validate :correct_old_password, on: :update
  validates :password, confirmation: true, allow_blank: true

  before_create :confirmation_token

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  private

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'Не верный'
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end
end