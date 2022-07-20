# frozen_string_literal: true

RSpec.describe 'Index', type: :feature do
  let!(:books) { create_list(:book, 5) }
  let!(:admin) { create(:admin_user) }
  let(:book_attributes) { %i[title price all_authors_fullname] }

  before do
    visit '/admin'
    fill_in('admin_user_email', with: admin.email)
    fill_in('admin_user_password', with: admin.password)
    click_button('Login')
    click_link('Books')
  end

  it 'displays book info' do
    book_attributes.each do |attribute|
      books.map(&:decorate).map(&attribute).each do |text|
        expect(page).to have_content(text)
      end
    end

    books.map { |book| book.category.name }.each do |category|
      expect(page).to have_content(category)
    end

    books.map { |book| book.decorate.short_description }.each do |description|
      expect(page).to have_content(description)
    end
  end
end
