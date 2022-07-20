# frozen_string_literal: true

RSpec.describe OrderItem, type: :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:book) }
    it do
      is_expected.to validate_numericality_of(:quantity)
        .is_greater_than_or_equal_to(described_class::MIN_QUANTITY).with_message(I18n.t('cart.low_quantity'))
    end
  end

  context 'with associations' do
    let(:order_item_association) { %i[book order] }

    it 'validate properties' do
      order_item_association.each do |association|
        is_expected.to belong_to(association)
      end
    end
  end
end
