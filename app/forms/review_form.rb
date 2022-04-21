# frozen_string_literal: true

class ReviewForm
  include ActiveModel::Model

  attr_accessor :title, :book_rate, :body, :book_id

  TEXT_FORMAT = %r/\A[\w!#$%&'*+-\/=?^`{|}~\s]+\z/.freeze
  RATE_RANGE = (0..5).freeze
  MAX_LENGTH = { title: 80, body: 500 }.freeze

  validates :title, :book_rate, :body, :book_id, presence: true
  validates :title, format: { with: TEXT_FORMAT }, length: { maximum: MAX_LENGTH[:title] }
  validates :body, format: { with: TEXT_FORMAT }, length: { maximum: MAX_LENGTH[:body] }
  validates :book_rate, numericality: { greater_than_or_equal_to: RATE_RANGE.first,
                                        less_than_or_equal_to: RATE_RANGE.last }

  def save(object)
    return false if invalid?

    object.reviews.create(params)
  end

  def params
    {
      title: title,
      book_rate: book_rate,
      body: body,
      book_id: book_id
    }
  end
end
