# frozen_string_literal: true

RSpec.describe Books::BestsellersQuery do
  subject { described_class.new.call }

  describe '.call' do
    let(:order) { create(:order, state: :in_delivery) }
    let!(:order_items) { create_list(:order_item, 4, order: order) }
    let!(:not_sold_books) { create_list(:book, 4) }

    context 'sold books' do
      let(:expected_result) { order_items.map(&:book).sort_by(&:id) }

      it 'returns best sold books' do
        expect(subject.sort_by(&:id)).to eq expected_result
      end
    end

    context 'not sold books' do
      it 'does not return books which not sold' do
        expect(subject).not_to include(not_sold_books)
      end
    end
  end
end
