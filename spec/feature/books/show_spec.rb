# frozen_string_literal: true

RSpec.describe 'books#show', type: :feature do
  let(:book) { create(:book) }

  describe 'book info' do
    before { visit book_path(book) }

    it 'displays book info' do
      expect(page).to have_content(book.title)
      expect(page).to have_content(book.description)
      expect(page).to have_content(book.decorate.all_authors_fullname)
    end
  end

  describe 'review form', js: true do
    let(:user) { create(:user) }

    before do
      sign_in user
      visit book_path(book)
    end

    context 'with valid input' do
      let(:review_attributes) { attributes_for(:review) }

      before do
        fill_in('review_title', with: review_attributes[:title])
        fill_in('review_body', with: review_attributes[:body])
        page.all(:css, '.fa-star').first.click
        click_button(I18n.t('button.post'))
      end

      it 'displays success messasge' do
        expect(page).to have_content(I18n.t('review.success'))
      end
    end

    context 'with invalid input' do
      before { click_button(I18n.t('button.post')) }

      it { expect(page).to have_content(I18n.t('errors.messages.blank')) }
    end
  end

  describe 'reviews' do
    let(:reviews_amount) { 5 }
    let!(:reviews) { create_list(:review, 5, book: book) }

    before { visit book_path(book) }

    it 'displays reviews' do
      expect(page.all('.general-message-wrap.divider-lg').count).to eq reviews_amount
    end

    it 'displays reviews titles' do
      reviews.map(&:title).each do |title|
        expect(page).to have_content(title)
      end
    end

    it 'displays reviews bodies' do
      reviews.map(&:body).each do |body|
        expect(page).to have_content(body)
      end
    end
  end
end
