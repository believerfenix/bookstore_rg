# frozen_string_literal: true

RSpec.describe QuickRegistrations::QuickRegistrationsService do
  subject(:service) { described_class.call(user_params: user_params) }

  describe '.call' do
    let(:user_params) { { email: attributes_for(:user)[:email] } }

    it 'returns instance of the service' do
      expect(subject).to be_a described_class
    end
  end

  describe '#success?' do
    context 'when service succeeded' do
      let(:user_params) { { email: attributes_for(:user)[:email] } }

      it 'returns true' do
        expect(service).to be_success
      end
    end

    context 'when service failed' do
      let(:user_params) { {} }

      it 'returns false' do
        expect(service).not_to be_success
      end

      it 'has errors message' do
        expect(service.errors_message).to be_present
      end
    end
  end
end
