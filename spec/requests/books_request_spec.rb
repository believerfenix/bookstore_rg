# frozen_string_literal: true

RSpec.describe 'BooksRequest', type: :request do
  describe 'GET /books' do
    before { get books_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders a books index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /books/:id' do
    context 'with valid book id' do
      let(:book) { create(:book) }

      before { get book_path(book) }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders a books index template' do
        expect(response).to render_template(:show)
      end
    end
  end
end
