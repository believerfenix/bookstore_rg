# frozen_string_literal: true

RSpec.describe CardDecorator do
  let(:decorated_card) { card.decorate }
  let(:card) { create(:card, order: order) }
  let(:order) { create(:order) }

  describe '#last_four_digits' do
    subject { decorated_card.last_four_digits }

    context 'with address' do
      let(:expected_result) { decorated_card.number.last(CardDecorator::LAST_DIGITS_AMOUNT) }

      it { is_expected.to eq(expected_result) }
    end
  end
end
