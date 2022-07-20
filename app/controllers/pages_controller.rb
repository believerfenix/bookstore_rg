# frozen_string_literal: true

class PagesController < ApplicationController
  LATEST_BOOKS_COUNT = 3
  BESTSELLERS_COUNT = 4

  decorates_assigned :latest_books

  def index
    @latest_books = Book.last(LATEST_BOOKS_COUNT)
    @bestsellers = bestsellers_books.first(BESTSELLERS_COUNT)
  end

  private

  def bestsellers_books
    Books::BestsellersQuery.new.call.decorate
  end
end
