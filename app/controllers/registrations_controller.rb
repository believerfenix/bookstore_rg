# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def update_resource(resource, params)
    without_password? ? update_without_password(resource, params) : super(resource, params)
  end

  private

  def without_password?
    params[resource_name][:password].blank?
  end

  def update_without_password(resource, params)
    resource.update_without_password(params)
  end
end
