# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  def show?
    user.present? && record.user.id.eql?(user.id)
  end

  def index?
    user.present?
  end

  class Scope < Scope
    attr_reader :user, :scope

    def resolve
      scope.where(user: user)
    end
  end
end
