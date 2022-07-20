# frozen_string_literal: true

RSpec.describe Book, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:author_books).dependent(:destroy) }
    it { is_expected.to have_many(:authors).through(:author_books) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_one_attached(:title_image) }
    it { is_expected.to have_many_attached(:images) }
  end

  context 'with validations' do
    let(:books_properties) { %i[title price] }

    context do
      it 'validates presence of property' do
        books_properties.each do |property|
          is_expected.to validate_presence_of(property)
        end
      end
    end

    context 'numericality' do
      it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(Book::MIN_PRICE) }
    end
  end
end
