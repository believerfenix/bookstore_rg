# frozen_string_literal: true

class CheckoutPolicy < ApplicationPolicy
  def show?
    user.present?
  end
end
