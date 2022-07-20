# frozen_string_literal: true

class Book < ApplicationRecord
  MIN_PRICE = 0.0

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books

  belongs_to :category

  has_many :reviews, dependent: :destroy

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  has_one_attached :title_image, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: MIN_PRICE }
end
