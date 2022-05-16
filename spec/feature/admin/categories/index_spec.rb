# frozen_string_literal: true

RSpec.describe 'Index', type: :feature do
  let!(:categories) { create_list(:category, 5) }
  let!(:admin) { create(:admin_user) }

  before do
    visit '/admin'
    fill_in('admin_user_email', with: admin.email)
    fill_in('admin_user_password', with: admin.password)
    click_button('Login')
    click_link('Categories')
  end

  it 'displays category name' do
    categories.map(&:name).each do |name|
      expect(page).to have_content(name)
    end
  end
end
