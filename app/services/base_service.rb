# frozen_string_literal: true

class BaseService
  attr_reader :errors, :success_message

  def self.call(**params)
    service = new(**params)
    service.call
    service
  end

  def success?
    @errors.empty?
  end

  def initialize(**_)
    @errors = []
  end

  def errors_message
    @errors.join(', ')
  end

  def assign_success_message(path)
    @success_message = I18n.t(path)
  end
end
