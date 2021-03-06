# frozen_string_literal: true

class BooksController < ApplicationController
  BOOKS_PER_PAGE = 12

  decorates_assigned :book, :books

  def index
    @filters = Books::SortBooksService::BOOK_FILTERS
    @pagy, @books = pagy_countless(scoped_books, link_extra: 'data-remote="true"', items: BOOKS_PER_PAGE)
    @books_count = Book.all.count
    @categories = Category.all
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def scoped_books
    Books::SortBooksService.new(params).call
  end
end
