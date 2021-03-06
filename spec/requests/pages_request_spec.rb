# frozen_string_literal: true

RSpec.describe 'PagesRequest', type: :request do
  describe 'GET /home' do
    before do
      create_list(:book, PagesController::LATEST_BOOKS_COUNT)
      get root_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders a home index template' do
      expect(response).to render_template(:index)
    end
  end
end
