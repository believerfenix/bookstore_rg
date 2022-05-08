# frozen_string_literal: true

RSpec.describe Cart::UpdateCartService do
  subject { described_class.call(order_params: order_params, order: order) }

  let(:order) { create(:order) }

  describe '.call' do
    let(:order_params) { attributes_for(:order_item) }

    it 'returns instance of the service' do
      expect(subject).to be_a described_class
    end

    context 'when order item updates' do
      let(:book) { create(:book) }
      let(:order_params) { { order_item: { book_id: book.id, quantity: 1 } } }

      before { subject }

      it 'calls UpdateOrderItemService' do
        expect(order.order_items.first).to have_attributes(order_params[:order_item])
      end
    end

    context 'when coupon updates' do
      let(:coupon) { create(:coupon) }
      let(:order_params) { { coupon: { code: coupon.code } } }

      before { subject }

      it 'calls AddCouponService' do
        expect(order.coupon).to have_attributes(order_params[:coupon])
      end
    end
  end

  describe '#success?' do
    context 'when service succeeded' do
      let(:coupon) { create(:coupon) }
      let(:order_params) { { coupon: { code: coupon.code } } }

      it 'returns true' do
        expect(subject).to be_success
      end
    end

    context 'when service failed' do
      let(:order_params) { { coupon: { code: '' } } }

      it 'returns false' do
        expect(subject).not_to be_success
      end
    end
  end
end
