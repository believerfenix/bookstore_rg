# frozen_string_literal: true

class PagesController < ApplicationController
  LATEST_BOOKS_COUNT = 3

  decorates_assigned :latest_books

  def index
    @latest_books = Book.last(LATEST_BOOKS_COUNT)
  end
end
