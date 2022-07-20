# frozen_string_literal: true

RSpec.describe 'index', type: :feature do
  context 'with slider' do
    let!(:books) { BookDecorator.decorate_collection(create_list(:book, PagesController::LATEST_BOOKS_COUNT)) }

    before do
      visit root_path
    end

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

    describe 'best sellers' do
      let(:order) { create(:order, state: :in_delivery) }
      let!(:order_items) { create_list(:order_item, PagesController::BESTSELLERS_COUNT, order: order) }
      let(:books_titles) { order_items.map { |item| item.book.title } }

      before { visit root_path }

      it "displays #{PagesController::BESTSELLERS_COUNT} best sold books" do
        books_titles.each do |title|
          expect(page).to have_content(title)
        end
      end
    end
  end
end
