# frozen_string_literal: true

RSpec.describe 'New', type: :feature do
  let(:user_data) { attributes_for(:user) }

  before do
    visit new_user_registration_path
  end

  context 'with valid input' do
    before do
      fill_in(I18n.t('devise.email'), with: user_data[:email])
      fill_in(I18n.t('devise.password'), with: user_data[:password])
      fill_in(I18n.t('devise.confirm_password'), with: user_data[:password])
      click_button(I18n.t('devise.sign_up'))
    end

    it 'registers user' do
      expect(page).to have_current_path(root_path)
    end
  end

  context 'with invalid input' do
    let(:invalid_email) { 'wertfds' }
    let(:invalid_password) { '12341234' }
    let(:invalid_confirmation_password) { invalid_password.reverse }

    before do
      fill_in(I18n.t('devise.email'), with: invalid_email)
      fill_in(I18n.t('devise.password'), with: invalid_password)
      fill_in(I18n.t('devise.confirm_password'), with: invalid_confirmation_password)
      click_button(I18n.t('devise.sign_up'))
    end

    it 'stays at sign up page displays invalid email/password/confirmation password message' do
      expect(page).to have_current_path(user_registration_path)
      expect(page).to have_content(I18n.t('activerecord.errors.models.user.attributes.email.invalid'))
      expect(page).to have_content(I18n.t('activerecord.errors.models.user.attributes.password.invalid'))
      expect(page).to have_content("doesn't match Password")
    end
  end
end
