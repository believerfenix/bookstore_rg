# frozen_string_literal: true

RSpec.describe Category, type: :model do
  context 'with associations' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end
end
