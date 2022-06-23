# frozen_string_literal: true

RSpec.describe CheckoutPolicy do
  subject { described_class }
  let(:user) { create :user }
  let(:fake_user) { nil }

  permissions :show? do
    it 'denies access if user not present' do
      expect(subject).not_to permit(fake_user)
    end

    it 'grants access if user present' do
      expect(subject).to permit(user)
    end
  end
end
