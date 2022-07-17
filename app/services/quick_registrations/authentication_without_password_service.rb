# frozen_string_literal: true

module QuickRegistrations
  class AuthenticationWithoutPasswordService < BaseService
    attr_reader :errors, :success_message, :user

    def initialize(params)
      super
      @params = params[:user_params]
    end

    def call
      create_user
      @user.persisted? ? @user.send_reset_password_instructions : @errors << @user.errors[:email]
    end

    private

    def create_user
      @user = User.new(quick_registrations_user_params)
      @user.skip_confirmation!
      @user.save
    end

    def quick_registrations_user_params
      password = Devise.friendly_token
      @params.merge(password: password, password_confirmation: password)
    end
  end
end
