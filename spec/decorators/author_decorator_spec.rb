# frozen_string_literal: true

RSpec.describe AuthorDecorator do
  let(:author) { create(:author).decorate }

  describe '#full_name' do
    subject { author.fullname }

    let(:expected_result) { "#{author.first_name} #{author.last_name}" }

    context 'when equals expected result' do
      it { is_expected.to eq(expected_result) }
    end
  end

  describe '#truncated_description' do
    subject { author.truncated_description }

    let(:expected_result) do
      author.description.truncate(AuthorDecorator::TRUNCATED_DESCRIPTION_LENGTH, separator: ' ')
    end

    context 'when equals expected result' do
      it { is_expected.to eq(expected_result) }
    end
  end
end
