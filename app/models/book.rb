# frozen_string_literal: true

class Book < ApplicationRecord
  MIN_PRICE = 0.0

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  belongs_to :category

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: MIN_PRICE }
end
