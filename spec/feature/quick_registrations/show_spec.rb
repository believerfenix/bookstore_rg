# frozen_string_literal: true

RSpec.describe 'QuickRegistrations', type: :feature do
  describe 'sign in form' do
    let(:user_data) { attributes_for(:user) }

    before do
      visit quick_registration_path
      within 'div.col-md-5.mb-40' do
        fill_in(I18n.t('devise.email'), with: user_data[:email])
        fill_in(I18n.t('devise.password'), with: user_data[:password])
      end
    end

    context 'when user exists' do
      before do
        create(:user, email: user_data[:email], password: user_data[:password])
        click_button(I18n.t('devise.log_in'))
      end

      it 'authorizes user and redirects to home page' do
        expect(page).to have_current_path(root_path)
      end
    end

    context 'with user does not exist' do
      let(:expected_content) { I18n.t('devise.failure.not_found_in_database', authentication_keys: 'Email') }

      before { click_button(I18n.t('devise.log_in')) }

      it 'redirects to sign in page' do
        expect(page).to have_current_path(new_user_session_path)
      end

      it 'displays invalid credencials message' do
        expect(page).to have_content(expected_content)
      end
    end
  end

  describe 'quick registration form' do
    let(:user_data) { attributes_for(:user) }
    let!(:book) { create(:book) }

    before do
      visit root_path
      click_link(I18n.t('home.buy_now'))
      visit quick_registration_path
    end

    context 'when email is valid' do
      let(:order) { create(:order) }

      before do
        within 'div.col-md-5.col-md-offset-1.mb-60' do
          fill_in(I18n.t('devise.email'), with: user_data[:email])
          click_button(I18n.t('checkouts.continue_checkout'))
        end
      end

      it 'registers user and redirects to checkout page' do
        expect(page).to have_current_path(checkout_path)
      end
    end

    context 'with email is invalid' do
      before { click_button(I18n.t('checkouts.continue_checkout')) }

      it 'stays at quick registration page' do
        expect(page).to have_current_path(quick_registration_path)
      end
    end
  end
end
