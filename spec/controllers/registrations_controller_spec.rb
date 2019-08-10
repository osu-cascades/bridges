require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:user) { build(:user) }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "#create" do
    it 'creates a new user session and redirects to user path' do
      post :create, params: { user: attributes_for(:user) }
      expect(response).to have_http_status(:redirect)
      expect(response.location.include?('http://test.host/users/')).to eq(true)
    end

    it 'creates a new user session without verifying recaptcha' do
      allow(controller).to receive(:verify_recaptcha).and_return(false)
      post :create, params: { user: attributes_for(:user) }
      expect(response).to have_http_status(:success)
    end
  end
end
