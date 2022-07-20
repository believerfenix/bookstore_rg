# frozen_string_literal: true

RSpec.describe User, type: :model do
  context 'with database columns' do
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:sign_in_count).of_type(:integer).with_options(default: 0, null: false) }
    it { is_expected.to have_db_column(:current_sign_in_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:last_sign_in_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:current_sign_in_ip).of_type(:string) }
    it { is_expected.to have_db_column(:last_sign_in_ip).of_type(:string) }
    it { is_expected.to have_db_column(:confirmation_token).of_type(:string) }
    it { is_expected.to have_db_column(:confirmed_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:confirmation_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:provider).of_type(:string) }
    it { is_expected.to have_db_column(:uid).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_index(:confirmation_token).unique }
    it { is_expected.to have_db_index(:email).unique }
    it { is_expected.to have_db_index(:reset_password_token).unique }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:email) }
    context 'presence' do
      it { is_expected.to validate_presence_of(:email) }
    end

    context 'with password' do
      let(:valid_password) { 'Abcdefg1' }
      context 'with valid password' do
        it { is_expected.to allow_value(valid_password).for(:password) }
      end
      context 'with invalid password' do
        %w[Abc abcdefg1 ABCDEFG1 Abcdefgh].each do |invalid_password|
          it { is_expected.not_to allow_value(invalid_password).for(:password) }
        end
      end
    end
  end

  context 'with associations' do
    %i[billing_address shipping_address].each do |model|
      it { is_expected.to have_one(model).dependent(:destroy) }
    end
  end
end
