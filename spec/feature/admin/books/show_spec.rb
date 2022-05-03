# frozen_string_literal: true

RSpec.describe 'Show', type: :feature do
  let(:book) { create(:book) }
  let!(:admin) { create(:admin_user) }
  let(:book_attributes) { Book.attribute_names.excluding('id', 'created_at', 'updated_at', 'category_id') }

  before do
    visit '/admin'
    fill_in('admin_user_email', with: admin.email)
    fill_in('admin_user_password', with: admin.password)
    click_button('Login')
    visit admin_book_path(book)
  end

  it 'displays book attribute and category' do
    book_attributes.each do |attribute|
      text = book.decorate.public_send(attribute)

      expect(page).to have_content(text)
    end

    expect(page).to have_content(book.category.name)
  end
end
