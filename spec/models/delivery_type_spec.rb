# frozen_string_literal: true

RSpec.describe DeliveryType, type: :model do
  context 'with associations' do
    it { is_expected.to have_many(:order_delivery_type).dependent(:destroy) }
    it { is_expected.to have_many(:orders).through(:order_delivery_type) }
  end
end
