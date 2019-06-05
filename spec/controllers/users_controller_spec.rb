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

  describe '#new' do
    login_admin

    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    login_admin

    context 'with valid attributes' do
      it 'creates new users' do
        user_params = FactoryBot.attributes_for(:user)
        expect { post :create, params: { user: user_params } }.to change(User, :count).by(1)
      end

      it 'redirects to index' do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to have_http_status(:redirect)
      end

      it 'produces correct flash notice' do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
        assert_equal 'User was successfully created.', flash[:notice]
      end
    end

    context 'with invalid attributes' do
      it 'does not save new user' do
        user_params = FactoryBot.attributes_for(:invalid_user)
        expect { post :create, params: { user: user_params } }.to_not change(User, :count)
      end

      it 'does not redirect to index' do
        post :create, params: { user: FactoryBot.attributes_for(:invalid_user) }
        expect(response).to_not have_http_status(:redirect)
      end
    end
  end

  describe '#update' do
    login_admin

    before do
      @user = create(:user)
    end

    context 'with valid attributes' do
      it 'updates user attributes' do
        put :update, params: { id: @user, user: FactoryBot.attributes_for(:user, first_name: 'Bobberson') }
        @user.reload
        expect(@user.first_name).to eq('Bobberson')
      end

      it 'redirects to the updated user' do
        put :update, params: { id: @user, user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to @user
      end

      it 'produces correct flash notice' do
        post :update, params: { id: @user, user: FactoryBot.attributes_for(:user, first_name: 'Bobberson') }
        assert_equal 'User was successfully updated.', flash[:notice]
      end
    end

    context 'with invalid attributes' do
      it 'does not update attributes' do
        put :update, params: { id: @user, user: FactoryBot.attributes_for(:invalid_user) }
        @user.reload
        expect(@user.first_name).to eq('Bob')
      end

      it 'does not redirect to updated user' do
        put :update, params: { id: @user, user: FactoryBot.attributes_for(:invalid_user) }
        expect(response).to_not redirect_to @user
      end
    end

    context 'without password' do
      it 'updates user attributes' do
        put :update, params: { id: @user, user: FactoryBot.attributes_for(:user, password: nil) }
        @user.reload
        expect(@user.password).to eq('password')
      end
    end
  end

  describe '#destroy' do
    login_admin

    before do
      @user = create(:user)
    end

    it 'deletes user' do
      expect { delete :destroy, params: { id: @user } }.to change(User, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: @user }
      expect(response).to redirect_to users_url
    end

    it 'produces correct flash notice' do
      delete :destroy, params: { id: @user }
      assert_equal 'User was successfully destroyed.', flash[:notice]
    end
  end
end
