# frozen_string_literal: true

RSpec.describe 'books#show', type: :feature do
  let(:book) { create(:book) }

  describe 'book info' do
    before { visit book_path(book) }

    it 'displays book title' do
      expect(page).to have_content(book.title)
    end

    it 'displays book description' do
      expect(page).to have_content(book.description)
    end

    it 'displays book authors' do
      expect(page).to have_content(book.decorate.all_authors_fullname)
    end
  end
end
