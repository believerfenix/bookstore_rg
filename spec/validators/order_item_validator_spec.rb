# frozen_string_literal: true

describe OrderItemValidator do
  subject { OrderItem.new(book: book, quantity: quantity, order: order) }
  let(:book) { create(:book) }
  let(:order) { create(:order) }

  describe 'max_quantity' do
    context 'valid_quantity' do
      let(:quantity) { rand(1..book.quantity) }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'invalid_quantity' do
      let(:quantity) { book.quantity + 5 }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end
  end
end
