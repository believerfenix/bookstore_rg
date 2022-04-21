# frozen_string_literal: true

class AuthorDecorator < Draper::Decorator
  delegate_all

  TRUNCATED_DESCRIPTION_LENGTH = 100

  def fullname
    "#{author.first_name} #{author.last_name}"
  end

  def truncated_description
    description&.truncate(TRUNCATED_DESCRIPTION_LENGTH, separator: ' ')
  end
end
