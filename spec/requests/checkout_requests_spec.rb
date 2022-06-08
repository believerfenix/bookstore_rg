# frozen_string_literal: true

RSpec.describe 'Checkout', type: :request do
  describe 'GET /checkout' do
    context 'when user ready to make order' do
      before { get checkout_path }

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end
    end
  end
end
