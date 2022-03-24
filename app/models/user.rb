# frozen_string_literal: true

class User < ApplicationRecord
  PASSWORD_FORMAT = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/.freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :password, format: { with: PASSWORD_FORMAT }, if: :password_required?
  validates :email, presence: true

  def self.from_omniauth(auth)
    name_split = auth.info.name.split
    user = User.find_by(email: auth.info.email)
    user ||= User.create!(provider: auth.provider, uid: auth.uid, last_name: name_split[0], first_name: name_split[1],
                          email: auth.info.email, password: Devise.friendly_token[0, 20])
    user
  end
end
