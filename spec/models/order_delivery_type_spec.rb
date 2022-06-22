# frozen_string_literal: true

RSpec.describe OrderDeliveryType, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:delivery_type) }
  end
end
