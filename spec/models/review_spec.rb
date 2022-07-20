# frozen_string_literal: true

RSpec.describe Review, type: :model do
  context 'with assosiations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end
end
