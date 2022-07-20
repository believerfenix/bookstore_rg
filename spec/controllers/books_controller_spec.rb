# frozen_string_literal: true

RSpec.describe BooksController, type: :controller do
  describe 'GET index' do
    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET show' do
    let(:book) { create(:book) }

    before { get :show, params: { id: book.id } }

    it 'render book template' do
      expect(response).to render_template :show
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
