# frozen_string_literal: true

RSpec.describe Books::SortBooksService do
  describe 'call' do
    subject { Books::SortBooksService.new(params).call }

    context 'with sorting' do
      let(:params) { { filter: :title_asc } }
      let(:expected_result) { Book.order(:title).map(&:id) }

      before { create_list(:book, 10) }

      it 'sorts books by sort parameter' do
        expect(subject.map(&:id)).to eq expected_result
      end
    end

    context 'with default sorting' do
      let(:params) { { filter: nil } }
      let(:default_filter) { Books::SortBooksService::BOOK_DEFAULT_FILTER }
      let!(:books) { create_list(:book, 10) }
      let(:expected_result) { books.sort_by(&:created_at).reverse!.map(&:id) }

      it 'sorts books by sort parameter' do
        expect(subject.map(&:id)).to eq expected_result
      end
    end

    context 'with category' do
      let(:category) { create(:category) }
      let(:category_book) { create(:book, category: category) }
      let(:another_category_book) { create(:book) }
      let(:params) { { category_id: category } }

      it 'filters books by category' do
        expect(subject).to include(category_book)
      end

      it 'returns only chosen category books' do
        expect(subject).not_to include(another_category_book)
      end
    end

    context 'without category' do
      let(:category) { create(:category) }
      let(:category_book) { create(:book, category: category) }
      let(:another_category_book) { create(:book) }
      let(:params) { { category_id: nil } }

      it 'show all books' do
        expect(subject).to include(category_book) and include(another_category_book)
      end
    end
  end
end
