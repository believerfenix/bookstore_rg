# frozen_string_literal: true

class PagePolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
