# frozen_string_literal: true

RSpec.describe 'books#index', type: :feature do
  context 'with books filtering' do
    let(:category) { create(:category) }
    let(:another_category) { create(:category) }
    let(:books_amount) { 2 }
    let!(:category_books) { BookDecorator.decorate_collection(create_list(:book, books_amount, category: category)) }
    let!(:another_category_books) do
      BookDecorator.decorate_collection(create_list(:book, books_amount, category: another_category))
    end

    before { visit books_path }

    it 'displays all books' do
      (category_books + another_category_books).each do |book|
        expect(page).to have_content(book.truncated_title)
      end
    end

    context 'with selected category' do
      before { first('ul.list-inline.pt-10.mb-25.mr-240') { click_link(category.name) } }

      it 'displays category books' do
        category_books.each do |book|
          expect(page).to have_content(book.truncated_title)
        end
      end
    end

    context 'with sorting' do
      let!(:books) { BookDecorator.decorate_collection(create_list(:book, books_amount)) }
      before { visit books_path }

      it 'displays created_at filter first' do
        books_titles = books.sort_by(&:created_at).reverse.map(&:truncated_title)
        displayed_titles = page.all('p.title').first(books_amount).map(&:text)
        expect(books_titles).to eq displayed_titles
      end

      Books::SortBooksService::BOOK_FILTERS.except(:created_at_desc).each_key do |filter|
        it "displays books sorted by #{I18n.t("book.sort.#{filter}")}}" do
          within('.hidden-xs.clearfix') { click_link(I18n.t("book.sort.#{filter}")) }

          books_titles = Books::SortBooksService.new({ filter: filter }).call
                                                .limit(books_amount).decorate.map(&:truncated_title)
          displayed_titles = page.all('p.title').first(books_amount).map(&:text)

          expect(books_titles).to eq displayed_titles
        end
      end
    end

    context 'with view more button' do
      let(:view_more_button) { I18n.t('catalog.load_more') }
      let!(:books) { create_list(:book, 20) }

      before { visit books_path }

      it 'displays View more button if not all books displayed' do
        expect(page).to have_content(view_more_button)
      end

      it 'disables View more button if all books displayed' do
        click_link(view_more_button)
        expect(page).not_to have_selector('span#next_link', text: I18n.t('catalog.load_more'))
      end
    end
  end
end
