# frozen_string_literal: true

RSpec.describe 'Orders', type: :request do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET /index' do
    before { get orders_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    let(:order) { create(:order, user: user, state: :delivered, delivery_type: delivery_type) }
    let!(:billing_address) { create(:address, kind: :billing, addressable: order) }
    let!(:shipping_address) { create(:address, kind: :shipping, addressable: order) }
    let(:delivery_type) { create(:delivery_type) }
    let(:order_items) { create_list(:order_item, 1) }
    let!(:card) { create(:card, order: order) }

    before { get order_path(order) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end
end
