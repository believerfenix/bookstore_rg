# frozen_string_literal: true

RSpec.describe OrderPolicy do
  subject { described_class }
  let(:user) { create(:user, orders: orders) }
  let(:fake_user) { nil }
  let(:wrong_user) { create :user, orders: fake_order }
  let(:orders) { create_list(:order, 3, state: :in_delivery) }
  let(:fake_order) { create_list(:order, 3, state: :delivered) }

  permissions :show? do
    it 'denies access if user is present but user is not the owner' do
      expect(subject).not_to permit(user, wrong_user.orders.first)
    end

    it 'denies access if user not present and is not the owner' do
      expect(subject).not_to permit(fake_user, fake_order)
    end

    it 'grants access if user present and user is the owner' do
      expect(subject).to permit(user, orders.first)
    end
  end

  permissions :index? do
    it 'denies access if user not present ' do
      expect(subject).not_to permit(fake_user)
    end

    it 'grants access if user present' do
      expect(subject).to permit(user)
    end
  end
end
