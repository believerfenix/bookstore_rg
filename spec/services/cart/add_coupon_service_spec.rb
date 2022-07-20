# frozen_string_literal: true

RSpec.describe Cart::AddCouponService do
  describe '.call' do
    subject { described_class.call(order: order, coupon: params) }

    let!(:order) { create(:order, order_items: order_items) }
    let!(:order_items) { create_list(:order_item, 5) }

    before { subject }

    context 'with coupon_update' do
      context 'with success coupon_update' do
        let(:coupon) { create(:coupon) }
        let(:params) { { code: coupon.code } }

        it 'add coupon' do
          expect(order.coupon).to eq(coupon)
        end
      end

      context 'with fail coupon_update' do
        let(:coupon) { create(:coupon, active: false) }
        let(:params) { { code: coupon.code } }

        it 'add coupon' do
          expect(order.coupon).not_to eq(coupon)
        end
      end

      context 'with invalid coupon_update' do
        let(:params) { { code: 'invalid' } }

        it 'add coupon' do
          expect(order.coupon).to be_nil
        end
      end
    end
  end
end
