# frozen_string_literal: true

RSpec.describe 'Index', type: :feature do
  let(:user) { create(:user, orders: all_orders) }
  let(:in_delivery_orders) { create_list(:order, 3, state: :in_delivery) }
  let(:delivered_orders) { create_list(:order, 3, state: :delivered) }
  let(:all_orders) { in_delivery_orders + delivered_orders }

  before do
    sign_in(user)
    visit orders_path
  end

  describe 'orders' do
    it 'displays all orders by default' do
      all_orders.map(&:id).each do |id|
        expect(page).to have_content(id)
      end
    end
  end

  describe 'filtering' do
    before do
      within 'div.dropdowns.dropdown' do
        click_link(I18n.t('orders.sort.delivered'))
      end
    end

    it 'displays delivered orders' do
      delivered_orders.map(&:id).each do |id|
        expect(page).to have_content(id)
      end
    end

    it 'does not display other orders' do
      in_delivery_orders.map(&:id).each do |id|
        expect(page).not_to have_content(id)
      end
    end
  end
end
