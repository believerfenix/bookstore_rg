# frozen_string_literal: true

RSpec.describe 'RegistrationsRequests', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    get edit_user_registration_path
  end

  describe 'GET /users/edit' do
    it 'return http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders a home index template' do
      expect(response).to render_template(:edit)
    end
  end
end
