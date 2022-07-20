# frozen_string_literal: true

RSpec.describe 'CartItemsRequests', type: :request do
  let(:order) { create(:order) }
  let(:book) { create(:book) }

  describe 'GET /cart' do
    before { get cart_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'POST /cart' do
    let(:params) { { order: { order_item: { book_id: book.id, quantity: 1 } } } }

    before { put cart_path, params: params }

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to previous page' do
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'PUT /cart' do
    let(:params) { { order: { order_item: { delete_id: book.id } } } }

    before { put cart_path, params: params }

    it 'returns http success' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to previous page' do
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST /coupon' do
    let(:coupon) { create(:coupon) }
    let(:params) { { order: { coupon: { code: coupon.code } } } }

    before { put cart_path, params: params }

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to previous page' do
      expect(response).to redirect_to(root_path)
    end
  end
end
