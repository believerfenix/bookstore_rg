# frozen_string_literal: true

RSpec.describe OrderDecorator do
  let(:decorated_order) { order.decorate }
  let(:order) { create(:order, order_items: order_items) }
  let(:order_items) { create_list(:order_item, 3) }
  let(:coupon) { create(:coupon) }

  describe '#order_items_subtotal' do
    subject { decorated_order.order_items_subtotal }

    let(:expected_result) do
      order_items.inject(0) { |sum, item| sum + (item.quantity * item.book.price) }
    end

    context 'when discount equals expected result' do
      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#discount' do
    subject { decorated_order.discount }

    context 'with coupon' do
      let(:expected_result) { coupon.sale }

      before { decorated_order.coupon = coupon }

      it { is_expected.to eq(expected_result) }
    end

    context 'without coupon' do
      let(:expected_result) { 0 }

      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#order_discount' do
    subject { decorated_order.order_discount }

    context 'without coupon' do
      let(:expected_result) { decorated_order.order_items_subtotal * coupon.sale }

      before { decorated_order.coupon = coupon }

      it { is_expected.to eq(expected_result) }
    end

    context 'without coupon' do
      let(:expected_result) { 0 }

      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#order_total' do
    subject { decorated_order.order_total }

    context 'without coupon' do
      let(:expected_result) do
        decorated_order.order_items_subtotal - (decorated_order.order_items_subtotal * coupon.sale)
      end

      before { decorated_order.coupon = coupon }

      it { is_expected.to eq(expected_result) }
    end

    context 'without coupon' do
      let(:expected_result) { decorated_order.order_items_subtotal }

      it { is_expected.to eq(expected_result) }
    end
  end
end
