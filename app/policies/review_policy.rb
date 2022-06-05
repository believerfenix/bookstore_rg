# frozen_string_literal: true

class ReviewPolicy < ApplicationPolicy
  def create?
    user.present?
  end
end
