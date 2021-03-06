# frozen_string_literal: true

class QuickRegistrationsController < ApplicationController
  include Devise::Controllers::Helpers

  def create
    service = QuickRegistrations::AuthenticationWithoutPasswordService.call(user_params: user_params)
    if service.success?
      sign_in(service.user)
      flash[:success] = I18n.t('quick_registration.success')
      redirect_to checkout_path
    else
      flash[:danger] = service.errors.join(' ')
      redirect_to quick_registration_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
