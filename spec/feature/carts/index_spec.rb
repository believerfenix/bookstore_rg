# frozen_string_literal: true

RSpec.describe 'carts#show', type: :feature do
  let!(:book) { create(:book) }

  before do
    visit root_path
    click_link(I18n.t('home.buy_now'))
    click_link(I18n.t('home.buy_now'))
    visit cart_path
  end

  describe 'order item deletion', js: true do
    subject { page.all('a.close.general-cart-close').count }
    let!(:expected_result) { page.all('a.close.general-cart-close').count - 1 }

    before do
      within 'table.table.table-hover' do
        page.all('a.close.general-cart-close').first.click
      end
    end

    it 'deletes order item from cart' do
      is_expected.to eq(expected_result)
    end
  end

  describe 'book amount increasing', js: true do
    subject { page.all('input.form-control.quantity-input').first.value.to_i }

    let!(:expected_result) { page.all('input.form-control.quantity-input').first.value.to_i + 1 }

    before do
      within 'table.table.table-hover' do
        page.all('i.fa.fa-plus').first.click
      end
      sleep(0.5)
    end

    it 'increment book amount' do
      is_expected.to eq(expected_result)
    end
  end

  describe 'book amount decreasing', js: true do
    subject { page.all('input.form-control.quantity-input').first.value.to_i }

    let!(:expected_result) { page.all('input.form-control.quantity-input').first.value.to_i - 1 }

    before do
      within 'table.table.table-hover' do
        page.all('i.fa.fa-minus').first.click
      end
      sleep(0.5)
    end

    it 'decreases book amount by 1' do
      is_expected.to eq(expected_result)
    end
  end

  describe 'coupon feature' do
    context 'when coupon invalid' do
      let(:invalid_coupon_code) { 'invalid' }

      before do
        fill_in(I18n.t('cart.enter_coupon_code'), with: invalid_coupon_code)
        click_button(I18n.t('button.apply_coupon'))
      end

      it 'displays invalid coupon message' do
        expect(page).to have_content(I18n.t('cart.invalid_coupon'))
      end
    end

    context 'when coupon valid' do
      let(:valid_coupon) { create(:coupon) }

      before do
        fill_in(I18n.t('cart.enter_coupon_code'), with: valid_coupon.code)
        click_button(I18n.t('button.apply_coupon'))
      end

      it 'adds coupon sale to the cart' do
        expect(page).to have_content(I18n.t('cart.coupon_added'))
      end
    end

    context 'when coupon was already used' do
      let(:used_coupon) { create(:coupon, active: false) }

      before do
        fill_in(I18n.t('cart.enter_coupon_code'), with: used_coupon.code)
        click_button(I18n.t('button.apply_coupon'))
      end

      it 'adds coupon sale to the cart' do
        expect(page).to have_content(I18n.t('cart.coupon_used'))
      end
    end
  end
end
  