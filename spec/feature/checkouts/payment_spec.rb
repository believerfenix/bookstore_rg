# frozen_string_literal: true

RSpec.describe 'Checkout Payment', type: :feature do
  let(:user) { create(:user) }
  let!(:order) { create(:order, order_items: order_items, delivery_type: delivery_type, state: :payment) }
  let(:order_items) { create_list(:order_item, 3) }
  let(:delivery_type) { create(:delivery_type) }
  let!(:billing_address) { create(:address, addressable: order, kind: :billing) }
  let!(:shipping_address) { create(:address, addressable: order, kind: :shipping) }

  before do
    page.set_rack_session(cart_id: order.id)
    sign_in(user)
  end

  describe 'card form', js: true do
    let(:card_data) { attributes_for(:card) }

    context 'when valid input' do
      before do
        visit checkout_path
        fill_in(I18n.t('checkouts.payment.placeholders.number'), with: card_data[:number])
        fill_in(I18n.t('checkouts.payment.placeholders.name'), with: card_data[:name])
        fill_in(I18n.t('checkouts.payment.placeholders.expiry_date'), with: card_data[:expiry_date])
        fill_in(I18n.t('checkouts.payment.placeholders.cvv'), with: card_data[:cvv])
        click_button(I18n.t('checkouts.save_and_continue'))
      end

      it 'renders next state' do
        expect(page).to have_selector('a', text: I18n.t('checkouts.confirm.place_order'))
      end
    end

    context 'when invalid input' do
      before do
        visit checkout_path
        click_button(I18n.t('checkouts.save_and_continue'))
      end

      it 'displays errors' do
        expect(page).to have_content(I18n.t('errors.messages.blank'))
      end
    end
  end
end
