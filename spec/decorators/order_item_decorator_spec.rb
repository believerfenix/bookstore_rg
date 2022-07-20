# frozen_string_literal: true

RSpec.describe OrderItemDecorator do
  subject(:decorator) { create(:order_item).decorate }

  describe '#subtotal' do
    let(:expected_result) { decorator.book.price * decorator.quantity }

    it 'returns price of a book multiplied by count' do
      expect(decorator.subtotal).to eq(expected_result)
    end
  end
end
