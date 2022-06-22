# frozen_string_literal: true

RSpec.describe 'Checkout Complete', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order, order_items: order_items, delivery_type: delivery_type, state: :complete) }
  let(:order_items) { create_list(:order_item, 3) }
  let(:delivery_type) { create(:delivery_type) }
  let!(:billing_address) { create(:address, addressable: order, kind: :billing) }

  before do
    sign_in(user)
    page.set_rack_session(cart_id: order.id)
    visit checkout_path
  end

  describe 'order' do
    it { expect(page).to have_content(order.id) }
  end

  describe 'billing address' do
    it { expect(page).to have_content(billing_address.first_name) }
    it { expect(page).to have_content(billing_address.last_name) }
    it { expect(page).to have_content(billing_address.city) }
    it { expect(page).to have_content(billing_address.address) }
    it { expect(page).to have_content(ISO3166::Country.find_country_by_alpha2(billing_address.country)) }
    it { expect(page).to have_content(billing_address.phone) }
  end

  describe 'order items' do
    it 'displays ordered books' do
      order.order_items.map { |item| item.book.title }.each do |title|
        expect(page).to have_content(title)
      end
    end
  end
end
