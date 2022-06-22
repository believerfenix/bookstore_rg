# frozen_string_literal: true

RSpec.describe Card, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:order) }
  end
end
