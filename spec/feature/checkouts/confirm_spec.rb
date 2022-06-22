# frozen_string_literal: true

RSpec.describe 'Checkout Confirm', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order, order_items: order_items, delivery_type: delivery_type, state: :confirm) }
  let(:order_items) { create_list(:order_item, 3) }
  let(:delivery_type) { create(:delivery_type) }
  let!(:billing_address) { create(:address, addressable: order, kind: :billing) }
  let!(:shipping_address) { create(:address, addressable: order, kind: :shipping) }
  let!(:card) { create(:card, order: order) }

  before do
    sign_in(user)
    page.set_rack_session(cart_id: order.id)
    visit checkout_path
  end

  describe 'billing address' do
    it { expect(page).to have_content(billing_address.first_name) }
    it { expect(page).to have_content(billing_address.last_name) }
    it { expect(page).to have_content(billing_address.city) }
    it { expect(page).to have_content(billing_address.address) }
    it { expect(page).to have_content(ISO3166::Country.find_country_by_alpha2(billing_address.country)) }
    it { expect(page).to have_content(billing_address.phone) }
  end

  describe 'shipping address' do
    it { expect(page).to have_content(shipping_address.first_name) }
    it { expect(page).to have_content(shipping_address.last_name) }
    it { expect(page).to have_content(shipping_address.city) }
    it { expect(page).to have_content(shipping_address.address) }
    it { expect(page).to have_content(ISO3166::Country.find_country_by_alpha2(shipping_address.country)) }
    it { expect(page).to have_content(shipping_address.phone) }
  end

  describe 'delivery' do
    it { expect(page).to have_content(delivery_type.name) }
  end

  describe 'card' do
    it { expect(page).to have_content(card.number[-4..]) }
    it { expect(page).to have_content(card.expiry_date) }
  end

  describe 'order items' do
    it 'displays ordered books' do
      order_items.map { |item| item.book.title }.each do |title|
        expect(page).to have_content(title)
      end
    end
  end

  describe 'order confirmation' do
    before { click_link(I18n.t('checkouts.confirm.place_order')) }

    it 'redirects to complete page' do
      expect(page).to have_content(I18n.t('checkouts.complete.thanks'))
    end
  end
end
