# frozen_string_literal: true

RSpec.describe 'Show', type: :feature do
  let(:review) { create(:review) }
  let!(:admin_attr) { attributes_for(:admin_user) }
  let!(:admin) { create(:admin_user, admin_attr) }
  let(:reviews_properties) { %i[title status book_rate] }

  before do
    visit '/admin'
    fill_in('admin_user_email', with: admin_attr[:email])
    fill_in('admin_user_password', with: admin_attr[:password])
    click_button('Login')
    visit admin_review_path(review)
  end

  describe 'review data' do
    it 'displays review attributes' do
      reviews_properties.each do |attribute|
        text = review.public_send(attribute)
        expect(page).to have_content(text)
      end
    end

    it 'displays review author email' do
      expect(page).to have_content(review.user.email)
    end

    it 'displays review  book title' do
      expect(page).to have_content(review.book.title)
    end
  end

  describe 'approve action' do
    before { click_link(I18n.t('activeadmin.reviews.approve')) }

    it 'displays approve message' do
      expect(page).to have_content(I18n.t('activeadmin.reviews.approved'))
    end
  end

  describe 'reject action' do
    before { click_link(I18n.t('activeadmin.reviews.reject')) }

    it 'displays approve message' do
      expect(page).to have_content(I18n.t('activeadmin.reviews.rejected'))
    end
  end
end
