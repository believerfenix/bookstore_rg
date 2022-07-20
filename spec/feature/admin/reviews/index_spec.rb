# frozen_string_literal: true

RSpec.describe 'Index', type: :feature do
  let(:reviews_amount) { 5 }
  let!(:admin_attr) { attributes_for(:admin_user) }
  let!(:admin) { create(:admin_user, admin_attr) }
  let(:reviews_properties) { %i[title status book_rate] }

  before do
    visit '/admin'
    fill_in('admin_user_email', with: admin_attr[:email])
    fill_in('admin_user_password', with: admin_attr[:password])
    click_button('Login')
  end

  describe 'unprocessed scope' do
    let!(:unprocessed_reviews) { create_list(:review, reviews_amount, status: Review.statuses[:unprocessed]) }

    before { click_link('Reviews') }

    it 'displays unprocessed reviews properties' do
      reviews_properties.each do |property|
        unprocessed_reviews.map(&property).each do |value|
          expect(page).to have_content(value)
        end
      end
    end

    it 'displays unprocessed reviews authors emails' do
      unprocessed_reviews.map { |review| review.user.email }.each do |email|
        expect(page).to have_content(email)
      end
    end
  end

  describe 'processed scope' do
    let!(:processed_reviews) { create_list(:review, reviews_amount) }

    before do
      click_link('Reviews')
      click_link('Processed')
    end

    it 'displays processed reviews properties' do
      reviews_properties.each do |property|
        processed_reviews.map(&property).each do |value|
          expect(page).to have_content(value)
        end
      end
    end

    it 'displays unprocessed reviews authors emails' do
      processed_reviews.map { |review| review.user.email }.each do |email|
        expect(page).to have_content(email)
      end
    end
  end
end
