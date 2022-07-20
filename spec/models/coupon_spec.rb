# frozen_string_literal: true

RSpec.describe Coupon, type: :model do
  context 'with validations' do
    let(:coupon_properties) { %i[sale code] }
    it 'validate properties' do
      coupon_properties.each do |property|
        is_expected.to validate_presence_of(property)
      end
    end

    it { is_expected.to validate_numericality_of(:sale).is_greater_than_or_equal_to(described_class::SALE_RANGE[:min]) }
    it { is_expected.to validate_numericality_of(:sale).is_less_than_or_equal_to(described_class::SALE_RANGE[:max]) }
  end
end
