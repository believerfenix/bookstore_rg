# frozen_string_literal: true

RSpec.describe 'Checkouts', type: :request do
  let(:user) { create(:user) }
  let(:order) { create(:order) }

  describe 'GET /checkout' do
    before do
      sign_in(user)
      get checkout_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'PUT /checkout' do
    let(:order_params) { { billing_address: attributes_for(:address, kind: :billing), only_billing: true } }

    before do
      sign_in(user)
      put checkout_path, params: { order: order_params }
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to show page' do
      expect(response).to redirect_to(checkout_path)
    end
  end
end
