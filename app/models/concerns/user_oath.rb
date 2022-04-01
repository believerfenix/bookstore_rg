# frozen_string_literal: true

module UserOath
  extend ActiveSupport::Concern

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end

  class_methods do
    def find_for_oauth(auth)
      authorization = Authorization.find_by(provider: auth.provider, uid: auth.uid)

      return authorization.user if authorization

      user_without_email(auth)
    end

    def user_without_email(auth)
      email = auth.info[:email]
      user = User.find_by(email: email)

      email ||= create_email(auth) if email.nil?

      unless user
        password = Devise.friendly_token
        user = User.create!(email: email, password: password, password_confirmation: password)
      end
      user.create_authorization(auth)

      user
    end

    def create_email(auth)
      "#{auth[:uid]}@bookstore.com"
    end
  end
end
