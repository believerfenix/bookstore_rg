# frozen_string_literal: true

RSpec.describe Cart::CartItemsCountService do
  include Devise::Test::IntegrationHelpers

  subject { described_class.new(session).call }

  let(:order) { create(:order, order_items: order_items) }
  let(:order_items) { create_list(:order_item, 3) }

  describe '.call' do
    context 'with full_cart' do
      let(:session) { { cart_id: order.id } }

      let(:expected_result) { order.order_items.sum(&:quantity) }

      it 'count cart items' do
        expect(subject).to eq(expected_result)
      end
    end

    context 'with empty cart' do
      let(:session) { { cart_id: order.id } }
      let(:order) { create(:order) }

      let(:expected_result) { 0 }

      it 'count cart items' do
        expect(subject).to eq(expected_result)
      end
    end
  end
end
