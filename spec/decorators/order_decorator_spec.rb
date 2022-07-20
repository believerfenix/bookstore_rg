# frozen_string_literal: true

RSpec.describe OrderDecorator do
  let(:decorated_order) { order.decorate }
  let(:order) { create(:order, order_items: order_items) }
  let(:order_items) { create_list(:order_item, 3) }
  let(:coupon) { create(:coupon) }
  let(:delivery_type) { create(:delivery_type) }
  let!(:billing_address) { create(:address, kind: :billing, addressable: order) }

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
      let(:expected_result) { - decorated_order.order_items_subtotal * coupon.sale }

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

    context 'with coupon' do
      let(:expected_result) do
        decorated_order.order_items_subtotal - (decorated_order.order_items_subtotal * coupon.sale)
      end

      before { decorated_order.coupon = coupon }

      it { is_expected.to eq(expected_result) }
    end

    context 'with coupon' do
      let(:expected_result) do
        decorated_order.order_items_subtotal + decorated_order.delivery_type.price
      end

      before { decorated_order.delivery_type = delivery_type }

      it { is_expected.to eq(expected_result) }
    end

    context 'without coupon' do
      let(:expected_result) { decorated_order.order_items_subtotal }

      it { is_expected.to eq(expected_result) }
    end

    context 'without delivery_price' do
      let(:expected_result) { decorated_order.order_items_subtotal }

      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#delivery_price' do
    subject { decorated_order.delivery_price }

    context 'with delivery_type' do
      let(:expected_result) { delivery_type.price }

      before { decorated_order.delivery_type = delivery_type }

      it { is_expected.to eq(expected_result) }
    end

    context 'without delivery_type' do
      let(:expected_result) { 0 }

      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#order_address' do
    subject { decorated_order.order_address('billing') }

    context 'with address' do
      let(:expected_result) { billing_address }

      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#address_credentials_full_name' do
    subject { decorated_order.address_credentials_full_name('billing') }

    context 'with address' do
      let(:expected_result) { billing_address.decorate.full_name }

      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#order_address_address' do
    subject { decorated_order.order_address_address('billing') }

    context 'with address' do
      let(:expected_result) { billing_address.address }

      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#order_address_country' do
    subject { decorated_order.order_address_country('billing') }

    context 'with address' do
      let(:expected_result) { ISO3166::Country.find_country_by_alpha2(billing_address.country) }

      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#address_city_with_zip' do
    subject { decorated_order.address_city_with_zip('billing') }

    context 'with address' do
      let(:expected_result) { "#{billing_address.city} #{billing_address.zip}" }

      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#address_phone' do
    subject { decorated_order.address_phone('billing') }

    context 'with address' do
      let(:expected_result) { billing_address.phone }

      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#last_state?' do
    subject { decorated_order }
    let(:not_last_state_index) do
      Order.aasm.states.map(&:name).excluding(:in_delivery, :delivered, :canceled).count - 2
    end
    let(:last_state_index) { Order.aasm.states.map(&:name).excluding(:in_delivery, :delivered, :canceled).count - 1 }

    it { is_expected.to be_last_state(last_state_index) }

    it { is_expected.not_to be_last_state(not_last_state_index) }
  end
end
