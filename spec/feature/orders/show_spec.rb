# frozen_string_literal: true

RSpec.describe 'Show', type: :feature do
  describe 'order data' do
    let(:decorated_orders) { OrderDecorator.decorate_collection(orders) }
    let(:user) { create(:user, orders: orders) }
    let(:orders) { create_list(:order, 1, delivery_type: delivery_type, order_items: order_items, state: :delivered) }
    let!(:billing_address) { create(:address, kind: :billing, addressable: orders.first) }
    let!(:shipping_address) { create(:address, kind: :shipping, addressable: orders.first) }
    let(:delivery_type) { create(:delivery_type) }
    let(:order_items) { create_list(:order_item, 1) }
    let!(:card) { create(:card, order: orders.first) }

    before do
      sign_in(user)
      visit order_path(orders.first)
    end

    context 'billing address' do
      let(:address_properties) do
        [
          decorated_orders.first.address_credentials_full_name('billing'),
          decorated_orders.first.address_city_with_zip('billing'),
          decorated_orders.first.order_address_country('billing'),
          decorated_orders.first.address_phone('billing'),
          decorated_orders.first.order_address_address('billing')
        ]
      end

      it 'displays billing address data' do
        address_properties.each do |property|
          expect(page).to have_content(property)
        end
      end
    end

    context 'shipping address' do
      let(:address_properties) do
        [
          decorated_orders.first.address_credentials_full_name('shipping'),
          decorated_orders.first.address_city_with_zip('shipping'),
          decorated_orders.first.order_address_country('shipping'),
          decorated_orders.first.address_phone('shipping'),
          decorated_orders.first.order_address_address('shipping')
        ]
      end

      it 'displays billing address data' do
        address_properties.each do |property|
          expect(page).to have_content(property)
        end
      end
    end

    context 'delivery type ' do
      let(:delivery_type_properties) { [delivery_type.name, delivery_type.price] }

      it 'displays delivery data' do
        delivery_type_properties.each do |property|
          expect(page).to have_content(property)
        end
      end
    end

    context 'card' do
      let(:decorated_card) { card.decorate }
      let(:card_properties) { [decorated_card.last_four_digits, decorated_card.expiry_date] }

      it 'displays card data' do
        card_properties.each do |property|
          expect(page).to have_content(property)
        end
      end
    end

    context 'order item' do
      let(:decorated_order_item) { order_items.first.decorate }
      let(:order_items_properties) do
        [
          decorated_order_item.book.title,
          decorated_order_item.book.description,
          decorated_order_item.book.price,
          decorated_order_item.quantity,
          decorated_order_item.subtotal
        ]
      end

      it 'displays order item data' do
        order_items_properties.each do |property|
          expect(page).to have_content(property)
        end
      end
    end

    context 'order' do
      let(:order_properties) { [decorated_orders.first.order_items_subtotal, decorated_orders.first.order_total] }

      it 'displays order data' do
        order_properties.each do |property|
          expect(page).to have_content(property)
        end
      end
    end
  end
end
