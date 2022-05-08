# frozen_string_literal: true

RSpec.describe Cart::UpdateOrderItemService do
  describe '.call' do
    subject { described_class.call(order: order, order_item_params: params) }

    let!(:order) { create(:order, order_items: order_items) }
    let!(:order_items) { create_list(:order_item, 5) }

    context 'with order_items_update' do
      context 'with existing item increment' do
        let(:params) { { book_id: order_items.first.book.id, quantity: 1 } }
        let!(:expected_result) { order.order_items.first.quantity + 1 }

        before do
          subject
          order.reload
        end

        it 'increase item quantity by 1' do
          expect(order.order_items.first.quantity).to eq(expected_result)
        end
      end

      context 'with existing item decrement' do
        let(:params) { { book_id: order_items.first.book.id, quantity: -1 } }
        let!(:expected_result) { order.order_items.first.quantity - 1 }

        before do
          subject
          order.reload
        end

        it 'decrease item quantity by 1' do
          expect(order.order_items.first.quantity).to eq(expected_result)
        end
      end

      context 'with adding new item' do
        let(:new_book) { create(:book) }
        let(:params) { { book_id: new_book.id, quantity: 1 } }
        let(:expected_result) { order.order_items.find_by(book_id: new_book.id) }

        before { subject }

        it 'Add 1 item' do
          expect(order.order_items).to include(expected_result)
        end
      end
    end

    context 'with order_item_destroy' do
      let(:params) { { destroy_id: order_items.first.id } }
      let!(:expected_result) { order.order_items.count - 1 }

      before { subject }

      it 'destroy item' do
        expect(order.order_items.count).to eq(expected_result)
      end
    end
  end
end
