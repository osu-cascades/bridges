require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  let(:organization) { create(:organization) }

  describe '#index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do
    it 'returns http success' do
      get :show, params: { id: organization.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#new' do
    login_admin

    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe '#edit' do
    login_admin

    it 'returns http success' do
      get :edit, params: { id: organization.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    login_admin

    context 'with valid attributes' do
      it 'creates new organizations' do
        organization_params = FactoryBot.attributes_for(:organization)
        expect { post :create, params: { organization: organization_params } }.to change(Organization, :count).by(1)
      end

      it 'redirects to index' do
        post :create, params: { organization: FactoryBot.attributes_for(:organization) }
        expect(response).to redirect_to organizations_path
      end

      it 'produces correct flash notice' do
        post :create, params: { organization: FactoryBot.attributes_for(:organization) }
        assert_equal 'Organization was successfully created.', flash[:success]
      end
    end

    context 'with invalid attributes' do
      it 'does not save new organization' do
        organization_params = FactoryBot.attributes_for(:invalid_organization)
        expect { post :create, params: { organization: organization_params } }.to_not change(Organization, :count)
      end

      it 'does not redirect to index' do
        post :create, params: { organization: FactoryBot.attributes_for(:invalid_organization) }
        expect(response).to_not redirect_to organizations_path
      end
    end
  end

  describe '#update' do
    login_admin

    before do
      @organization = create(:organization)
    end

    context 'with valid attributes' do
      it 'updates organization attributes' do
        put :update, params: { id: @organization, organization: FactoryBot.attributes_for(:organization, name: 'Lettuce NOT Taco Bout It') }
        @organization.reload
        expect(@organization.name).to eq('Lettuce NOT Taco Bout It')
      end

      it 'redirects to the updated organization' do
        put :update, params: { id: @organization, organization: FactoryBot.attributes_for(:organization) }
        expect(response).to redirect_to @organization
      end

      it 'produces correct flash notice' do
        post :update, params: { id: @organization, organization: FactoryBot.attributes_for(:organization, name: 'Lettuce NOT Taco Bout It') }
        assert_equal 'Organization was successfully updated.', flash[:success]
      end
    end

    context 'with invalid attributes' do
      it 'does not update attributes' do
        put :update, params: { id: @organization, organization: FactoryBot.attributes_for(:invalid_organization) }
        @organization.reload
        expect(@organization.name).to eq('Lettuce Taco Bout It')
      end

      it 'does not redirect to updated organization' do
        put :update, params: { id: @organization, organization: FactoryBot.attributes_for(:invalid_organization) }
        expect(response).to_not redirect_to @organization
      end
    end
  end

  describe '#destroy' do
    login_admin

    before do
      @organization = create(:organization)
    end

    it 'deletes organization' do
      expect { delete :destroy, params: { id: @organization } }.to change(Organization, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: @organization }
      expect(response).to redirect_to organizations_url
    end

    it 'produces correct flash notice' do
      delete :destroy, params: { id: @organization }
      assert_equal 'Organization was successfully destroyed.', flash[:success]
    end
  end
end
