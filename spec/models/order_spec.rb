# frozen_string_literal: true

RSpec.describe Order, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:user).optional(true) }
    it { is_expected.to have_one(:coupon).dependent(:destroy) }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:order_items) }
  end
end
