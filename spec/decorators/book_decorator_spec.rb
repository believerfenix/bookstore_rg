# frozen_string_literal: true

RSpec.describe BookDecorator do
  let(:book) { create(:book).decorate }

  describe '#all_authors_fullname' do
    subject { book.all_authors_fullname }
    let(:expected_result) do
      "#{book.authors.first.first_name} #{book.authors.first.last_name}, "\
        "#{book.authors.second.first_name} #{book.authors.second.last_name}"
    end

    context 'when equals expected result' do
      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#truncated_all_authors_fullname' do
    subject { book.truncated_all_authors_fullname }
    let(:expected_result) do
      book.all_authors_fullname.truncate(BookDecorator::TRUNCATED_LENGTH[:all_authors_fullname], separator: ' ')
    end

    context 'when equals expected result' do
      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#truncated_title' do
    subject { book.truncated_title }
    let(:expected_result) { book.title.truncate(BookDecorator::TRUNCATED_LENGTH[:title], separator: ' ') }

    context 'when equals expected result' do
      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#short_description' do
    subject { book.short_description }
    let(:expected_result) do
      book.short_description.truncate(BookDecorator::TRUNCATED_LENGTH[:description], separator: ' ')
    end

    context 'when equals expected result' do
      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#resize_title_image' do
    subject { book.resize_title_image(500) }

    let(:expected_result) { 500 }
    before { subject.blob.analyze }

    context 'when equals expected result' do
      it 'resize title image' do
        expect(subject.blob.metadata['width']).to eq(expected_result)
      end
    end
  end

  describe '#resized_images' do
    subject { book.resized_images(500) }

    let(:expected_result) { 500 }
    before { subject.each { |image| image.blob.analyze } }

    context 'when equals expected result' do
      it ' resize image' do
        expect(subject.first.blob.metadata['width']).to eq(expected_result)
      end
    end
  end
end
