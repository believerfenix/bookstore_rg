# frozen_string_literal: true

RSpec.describe AddressDecorator do
  let(:decorated_address) { address.decorate }
  let(:address) { create(:address, addressable: order) }
  let(:order) { create(:order) }

  describe '#order_address_country' do
    subject { decorated_address.full_name }

    context 'with address' do
      let(:expected_result) { "#{decorated_address.first_name} #{decorated_address.last_name}" }

      it { is_expected.to eq(expected_result) }
    end
  end
end
