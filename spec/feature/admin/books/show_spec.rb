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

  %i[title price all_authors_fullname description publication_year width height depth materials].each do |attribute|
    it "displays book #{attribute}" do
      text = book.decorate.public_send(attribute)
      expect(page).to have_content(text)
    end
  end
end
