# frozen_string_literal: true

RSpec.describe AddressPolicy do
  subject { described_class }
  let(:user) { create :user }
  let(:fake_user) { nil }
  let(:wrong_user) { create :user }
  let(:address) { AddressForm.new }
  let(:address_with_user) { AddressForm.new(user: user) }
  let(:address_with_wrong_user) { AddressForm.new(user: wrong_user) }

  permissions :update? do
    it 'denies access if user is present but user is not the owner' do
      expect(subject).not_to permit(user, address_with_wrong_user)
    end

    it 'denies access if user not present and is not the owner' do
      expect(subject).not_to permit(fake_user, address)
    end

    it 'grants access if user present and user is the owner' do
      expect(subject).to permit(user, address_with_user)
    end
  end
end
