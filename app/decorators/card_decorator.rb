# frozen_string_literal: true

class CardDecorator < Draper::Decorator
  delegate_all

  LAST_DIGITS_AMOUNT = 4

  def last_four_digits
    number.last(LAST_DIGITS_AMOUNT)
  end
end
