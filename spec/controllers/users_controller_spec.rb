require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { build(:user) }
  let(:admin_user) { build(:user, :admin) }

  describe '#index' do
    context 'user is admin' do
      login_admin

      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'user is not admin' do
      login_user

      it 'redirects to homepage' do
        get :index
        expect(response).to redirect_to(root_path)
        expect(subject.request.flash[:alert]).to eq('Access denied.')
      end
    end
  end

  describe '#show' do
    context 'user views own profile' do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'returns http success' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'admin views a profile' do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(admin_user)
        allow(controller).to receive(:current_user).and_return(admin_user)
      end

      it 'returns http success' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "user views another's profile" do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(other_user)
        allow(controller).to receive(:current_user).and_return(other_user)
      end

      it 'redirects to root' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
