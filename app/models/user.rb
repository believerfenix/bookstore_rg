# frozen_string_literal: true

class User < ApplicationRecord
  PASSWORD_FORMAT = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/.freeze

  has_one :billing_address, -> { billing },
          inverse_of: :user, class_name: 'Address', dependent: :destroy
  has_one :shipping_address, -> { shipping },
          inverse_of: :user, class_name: 'Address', dependent: :destroy

  has_many :reviews, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :password, format: { with: PASSWORD_FORMAT }, if: :password_required?
  validates :email, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end
end
