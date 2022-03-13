# frozen_string_literal: true
# frozen_string_literal: true

RSpec.describe 'index', type: :feature do
  context 'with slider' do
    let!(:books) { BookDecorator.decorate_collection(create_list(:book, PagesController::LATEST_BOOKS_COUNT)) }

    before { visit root_path }

    it "has #{PagesController::LATEST_BOOKS_COUNT} books indicators" do
      within('ol.carousel-indicators') { expect(page).to have_selector('li', count: books.count) }
    end

    it 'has books data' do
      books.each do |book|
        expect(page).to have_content(book.title)
        expect(page).to have_content(book.short_description)
        expect(page).to have_content(book.all_authors_fullname)
      end
    end
  end
end
