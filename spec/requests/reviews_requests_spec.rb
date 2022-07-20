# frozen_string_literal: true

RSpec.describe 'ReviewsRequests', type: :request do
  describe 'POST /reviews_request' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    let(:review_attributes) { attributes_for(:review) }
    let(:review_post_data) do
      review_attributes.except(:status).merge(book_id: book.id)
    end

    before do
      sign_in user
      post reviews_path, params: { review: review_post_data }
    end

    it 'returns https redirect status' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirect to book page' do
      expect(response).to redirect_to(book_path(id: book.id))
    end
  end
end
