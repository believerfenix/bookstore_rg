# frozen_string_literal: true

module Books
  class SortBooksService
    BOOK_DEFAULT_FILTER = :created_at_desc
    BOOK_FILTERS = {
      created_at_desc: { created_at: :desc },
      popular_asc: { created_at: :desc },
      price_asc: { price: :asc },
      price_desc: { price: :desc },
      title_asc: { title: :asc },
      title_desc: { title: :desc }
    }.freeze

    def initialize(params)
      @category_id = params[:category_id]
      @filter = params[:filter]&.to_sym || BOOK_DEFAULT_FILTER
    end

    def call
      find_books
      order_by_filter
    end

    private

    def find_books
      @books = @category_id ? Book.where(category_id: @category_id) : Book.all
    end

    def order_by_filter
      @books.order(BOOK_FILTERS[@filter])
    end
  end
end
