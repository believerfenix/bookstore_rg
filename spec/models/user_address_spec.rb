# frozen_string_literal: true

RSpec.describe UserAddress, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:address_id) }
  end

  context 'with assosiations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:address) }
  end
end
